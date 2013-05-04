using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AgingMVC.Models
{
    public class VideoModel
    {
        public string ID { get; set; }
        public string Video { get; set; }
        public int? Width { get; set; }
        public int? Height { get; set; }
    }
}