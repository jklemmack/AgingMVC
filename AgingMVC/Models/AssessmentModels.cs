using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AgingMVC.Models
{
    public class AssessmentPage
    {
        public int DomainId;
        public int Page;
    }

    public class TaskInfo
    {
        public int TaskId;
        public string ShortText;
        public string PromptText;
        public string Description;
    }

    public class VideoInfo
    {
        public int Index;
        public int VideoID;
        public string ShortText;
        public string Description;
        public string Copyright;
        public string ThumbImageURL;
        public int Type;
        public string URL;
    }

    //public class Survey
    //{
    //    public int TaskId;
    //    public int ObjectiveId;
    //    public int DomainId;
    //    public int TaskOrder;
    //    public string ShortText;

    //    public string PromptText;
    //    public string AssessmentText;

    //    public string PromptTextSelf;
    //    public string AssessmentTextSelf;

    //    public DateTime? LastUpdated;
    //    public bool Completed;
    //    public int? Timeline;


    //}

}