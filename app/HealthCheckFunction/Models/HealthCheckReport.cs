using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace com.dxc.lxp.HealthCheckFunction.Models
{
    public class HealthCheckReport
    {
        public string Status { get; set; }
        public Dictionary<string, string> Dependencies { get; set; } = new Dictionary<string, string>();

    }
}
