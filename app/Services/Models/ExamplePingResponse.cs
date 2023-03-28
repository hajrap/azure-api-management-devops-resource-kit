using System;

namespace com.dxc.lxp.Services.Models
{
    public class ExamplePingResponse
    {
        public Status Status { get; set; }
        public Exception Error { get; set; }
        public string Payload { get; set; }
    }
}
