namespace com.dxc.lxp.HealthCheckFunction.Config
{
    public class FuncOptions
    {
        public string KeyVaultUri { get; set; }
        public string KeyVaultTestSecretName { get; set; }
        //public string KeyVaultTestExpectedSecretValue { get; set; }
        public string ExampleParamOne { get; set; }
        public string ExampleParamTwo { get; set; }
        public bool DetailedHealthCheckReports { get; set; }
        public bool ExcludeHealthyReports { get; set; }
    }
}
