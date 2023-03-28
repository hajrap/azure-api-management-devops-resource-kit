using com.dxc.lxp.Services.Models;
using System;
using System.Threading.Tasks;

namespace com.dxc.lxp.Services
{
    public class ExampleService : IExampleService
    {

        public async Task<ExamplePingResponse> PingAsync(ExamplePingRequest request)
        {
            ExamplePingResponse response = new ExamplePingResponse();

            try
            {
                response.Status = Status.success;

                //wait 1 second to simulate some load
                await Task.Delay(1000);

                if (response.Status == Status.success)
                {
                    response.Payload = $"Add response payload here, usually some json";
                }
                else
                {
                    response.Payload = $"Added error message here such as, resource not found";
                }

                return response;
            }
            catch (Exception ex)
            {
                response.Status = Status.exception;
                response.Error = ex;
                response.Payload = $"Failure due to exception, message: {ex.Message}";
                return response;
            }
        }
    }
}
