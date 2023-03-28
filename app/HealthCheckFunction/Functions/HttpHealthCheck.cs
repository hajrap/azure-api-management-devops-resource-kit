using com.dxc.lxp.HealthCheckFunction.Config;
using com.dxc.lxp.HealthCheckFunction.Models;
using com.dxc.lxp.Services;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using Microsoft.Extensions.Options;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text.Json;
using System.Threading.Tasks;

namespace com.dxc.lxp.HealthCheckFunction
{
    public class HttpHealthCheck
    {
        private readonly HealthCheckService _healthCheck;
        private readonly string _httpHeaderName = "Content-Type";
        private readonly string _httpHeaderValue = "text/plain; charset=utf-8";

        public HttpHealthCheck(IOptions<FuncOptions> settings, IExampleService keyVaultService, HealthCheckService healthCheck)
        {
            _healthCheck = healthCheck;
        }

        [Function("HttpHealthCheck")]
        public async Task<HttpResponseData> RunAsync([HttpTrigger(AuthorizationLevel.Function, "get", "post")] HttpRequestData req,
            FunctionContext executionContext)
        {

            HealthReport status = await _healthCheck.CheckHealthAsync();

            if (status.Status == HealthStatus.Unhealthy || status.Status == HealthStatus.Degraded)
            {
                HttpResponseData unHealtyResponse = req.CreateResponse(HttpStatusCode.InternalServerError);
                unHealtyResponse.Headers.Add(_httpHeaderName, _httpHeaderValue);
                unHealtyResponse.WriteString(printReport(status));
                return unHealtyResponse;
            }
            else
            {
                HttpResponseData healtyResponse = req.CreateResponse(HttpStatusCode.OK);
                healtyResponse.Headers.Add(_httpHeaderName, _httpHeaderValue);
                healtyResponse.WriteString(printReport(status));
                return healtyResponse;
            }
        }

        private string printReport(HealthReport report)
        {
            string json = null;
            HealthCheckReport result = new HealthCheckReport();
            result.Status = report.Status.ToString();

            if(report.Entries != null && report.Entries.Count > 0)
            {
                foreach (KeyValuePair<string, HealthReportEntry> entry in report.Entries)
                {
                    result.Dependencies.Add(entry.Key, entry.Value.Status.ToString());
                }
            }

            json = JsonSerializer.Serialize<HealthCheckReport>(result);

            return json;
        }
    }
}
