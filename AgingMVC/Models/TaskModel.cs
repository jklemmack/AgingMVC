using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace AgingMVC.Models
{
    [MetadataType(typeof(TaskMetadata))]
    public partial class Task
    {
    }

    public class TaskMetadata
    {
        [Display(Name = "Order")]
        public int TaskOrder;

        [Display(Name = "Title")]
        public string ShortText;


        [DataType(DataType.Text)]
        [Display(Name = "Summary for other")]
        public string PromptText;

        [DataType(DataType.MultilineText)]
        [Display(Name = "Details for other")]
        public string AssessmentText;

        [DataType(DataType.Text)]
        [Display(Name = "Summary for self")]
        public string PromptTextSelf;

        [DataType(DataType.MultilineText)]
        [Display(Name = "Details for self")]
        public string AssessmentTextSelf;

    }
}