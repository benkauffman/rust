module.exports = async ({ resolveVariable }) => {
    
    const domain = await resolveVariable('self:custom.config.domain');
    const certificateName = await resolveVariable('self:custom.config.domain');

    return {
        subjectAlternativeNames: [`*.${domain}`],
        hostedZoneNames: domain,
        certificateName,
    }
}