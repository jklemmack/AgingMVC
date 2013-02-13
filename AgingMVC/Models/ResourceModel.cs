using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AgingMVC.Models
{
    public class ResourceModel
    {
        public int DomainId { get; set; }
        public string DomainName { get; set; }
        public int TaskId { get; set; }
        public string TaskName { get; set; }
        public string TaskDescription { get; set; }
    }


}