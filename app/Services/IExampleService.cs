using com.dxc.lxp.Services.Models;
using System.Threading.Tasks;

namespace com.dxc.lxp.Services
{
    public interface IExampleService
    {
        Task<ExamplePingResponse> PingAsync(ExamplePingRequest request);
    }
}
