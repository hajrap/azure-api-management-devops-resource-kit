using com.dxc.lxp.HealthCheckFunction.Config;
using com.dxc.lxp.Services;
using com.dxc.lxp.Services.Models;
using Microsoft.ApplicationInsights;
using Microsoft.ApplicationInsights.Extensibility;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Options;
using System;
using System.Net;
using System.Threading.Tasks;

namespace com.dxc.lxp.HealthCheckFunction
{
    public class HttpExample
    {
        private readonly FuncOptions _settings;
        private readonly IExampleService _service;
        private readonly TelemetryClient _telemetryClient;
        private readonly string _httpHeaderName = "Content-Type";
        private readonly string _httpHeaderValue = "text/plain; charset=utf-8";

        public HttpExample(
            IOptions<FuncOptions> settings
            , IExampleService service
            , IOptions<TelemetryConfiguration> telemetryConfiguration
            )
        {
            _service = service;
            TelemetryConfiguration tc = telemetryConfiguration?.Value;
            _settings = settings.Value;
            _telemetryClient = new TelemetryClient(tc);
        }

        [Function("HttpExample")]
        public async Task<HttpResponseData> RunAsync([HttpTrigger(AuthorizationLevel.Function, "get", "post")] HttpRequestData req,
            FunctionContext executionContext)
        {

            HttpResponseData result = null;

            try
            {
                ExamplePingRequest request = new ExamplePingRequest
                {
                    ParamOne = _settings.ExampleParamOne,
                    ParamTwo = _settings.ExampleParamTwo
                };

                ExamplePingResponse response = await _service.PingAsync(request);

                if (response.Status == Status.faulure)
                {
                    result = req.CreateResponse(HttpStatusCode.InternalServerError);
                    result.Headers.Add(_httpHeaderName, _httpHeaderValue);
                    result.WriteString(response.Payload);
                }
                else if (response.Status == Status.success)
                {
                    result = req.CreateResponse(HttpStatusCode.OK);
                    result.Headers.Add(_httpHeaderName, _httpHeaderValue);
                    result.WriteString(response.Payload);
                }
                else //must have run into an exception
                {
                    //Log Exception
                    LogException(response.Error);
                    result = req.CreateResponse(HttpStatusCode.InternalServerError);
                    result.Headers.Add(_httpHeaderName, _httpHeaderValue);
                    result.WriteString(response.Payload);
                }

                return result;

            }
            catch (Exception ex)
            {
                result = req.CreateResponse(HttpStatusCode.InternalServerError);
                result.Headers.Add(_httpHeaderName, _httpHeaderValue);
                result.WriteString(ex.Message);
                LogException(ex);
                return result;
            }
        }

        private void LogException(Exception ex)
        {
            _telemetryClient.TrackException(ex);
        }
    }
}
