module.exports = async ({ resolveVariable }) => {

    const name = await resolveVariable('self:custom.name');
    const domain = await resolveVariable('self:custom.config.domain');
    const stage = await resolveVariable('self:custom.config.stage');
    const certificateName = await resolveVariable('self:custom.config.domain');

    const basePath = '';
    const createRoute53Record = true;
    const securityPolicy = 'tls_1_2';
    const autoDomain = false;
    const apiType = 'http'; // http or rest
    const endpointType = 'regional'; // edge or regional
    const allowPathMatching = false;

    return {
        domainName: `${name}.${domain}`,
        stage,
        basePath,
        certificateName,
        createRoute53Record,
        securityPolicy,
        autoDomain,
        apiType,
        endpointType,
        allowPathMatching,
    }
}