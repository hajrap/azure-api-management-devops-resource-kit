using Azure.Identity;
using com.dxc.lxp.HealthCheckFunction.Config;
using com.dxc.lxp.Services;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System;
using System.Threading.Tasks;

namespace com.dxc.lxp.HealthCheckFunction
{
    public class Program
    {
        public static async Task Main()
        {
            string keyVaultUri = GetEnvironmentVariable("FuncOptions:KeyVaultUri");
            string keyVaultSecretName = GetEnvironmentVariable("FuncOptions:KeyVaultTestSecretName");
            string appInsightsKey = GetEnvironmentVariable("APPINSIGHTS_INSTRUMENTATIONKEY");
            bool detailedHealthCheckReports = bool.Parse(GetEnvironmentVariable("FuncOptions:DetailedHealthCheckReports"));
            bool excludeHealthyReports = bool.Parse(GetEnvironmentVariable("FuncOptions:ExcludeHealthyReports"));

            IHost host = new HostBuilder()
                .ConfigureFunctionsWorkerDefaults()
                .ConfigureServices(s =>
                {
                    s.AddOptions<FuncOptions>()
                    .Configure<IConfiguration>((settings, configuration) =>
                    {
                        configuration.GetSection("FuncOptions").Bind(settings);
                    });

                    s.AddHealthChecks()
                    .AddAzureKeyVault(new Uri(keyVaultUri), new DefaultAzureCredential(), options =>
                    {
                        options.AddSecret(keyVaultSecretName);
                    })
                    .AddApplicationInsightsPublisher(appInsightsKey, detailedHealthCheckReports, excludeHealthyReports);
                    s.AddTransient<IExampleService, ExampleService>();
                })
                .Build();

            await host.RunAsync();
        }

        public static string GetEnvironmentVariable(string name)
        {
            return System.Environment.GetEnvironmentVariable(name, EnvironmentVariableTarget.Process);
        }
    }
}