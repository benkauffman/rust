const fs = require('fs');
const url = require('url');
const { exec } = require('child_process');
const express = require('express');

// Create an Express app
const app = express();

app.use(express.json());  // Ensure JSON middleware is used

// run artillery test and parse the results
const runArtilleryTest = (target, callback = () => { }) => {

    const { hostname, port } = url.parse(target);
    const output = `${hostname}.${port}.${new Date().getTime()}.report.json`;
    const cmd = `artillery run --output "./output/${output}" --target "${target}" config.yaml`;

    console.log('Running Artillery:', cmd);

    exec(cmd, (error, stdout, stderr) => {
        if (error) {
            console.error(`Error: ${error.message}`);
            callback(error);
            return;
        }

        try {
            console.log(stdout);
            // const parsed = JSON.parse(fs.readFileSync(`./output/${output}`, 'utf8'));

            // console.log('Parsed data:', parsed);

            // const { summaries, histograms } = parsed.aggregate;

            // console.log(`${hostname}:${port} Summaries:`, summaries['http.response_time']);
            // console.log(`${hostname}:${port} Histograms:`, histograms['http.response_time']);

        } catch (error) {
            console.error('Failed to parse JSON:', error);
        }

        callback();
    });
}

// A route to trigger artillery tests on a signle target
app.get('/test/', (req, res) => {
    const { target = 'http://localhost:8081' } = req.query;
    console.log('Test:', { target });
    try {
        runArtilleryTest(target);
        res.json({ message: 'Test started', target });
    } catch (error) {
        res.status(500).json({ message: 'Error starting test', error });
    }
});

// A route to trigger artillery tests on all targets
app.get('/test/all', async (req, res) => {

    const { sync } = req.query;

    const targets = [
        'http://rust-hello-world:8080',
        'http://node-hello-world:8081',
        'http://python-hello-world:8082',
        'http://go-hello-world:8083',
        'http://java-hello-world:8084'
    ];

    console.log('Tests:', { targets });

    res.json({ message: 'Tests started', targets });

    for (let i = 0; i < targets.length; i++) {
        console.log('Running test:', targets[i]);

        if (sync === 'true') {
            await new Promise((resolve) => {
                runArtilleryTest(targets[i], resolve);
            })
        } else {
            runArtilleryTest(targets[i]);
        }

    }

});

// A route to check the health of the server
app.get('/_health', async (req, res) => {
    res.send('OK');
});

// Start the server
app.listen(3001, () => {
    console.log('Server listening on port 3001');
});
