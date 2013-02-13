<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Assessment.Master"
    Inherits="System.Web.Mvc.ViewPage<List<AgingMVC.Models.GetAssessment_Result>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%:ViewBag.Domain %>
    Evaluation
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
    <style>
        div.task
        {
            border-bottom: 1px dotted #CCCCCC;
            clear: both;
            width: 100%;
        }
        
        div.tasktext
        {
            background: none repeat scroll 0 0 #EEEEEE;
            clear: both;
            float: left;
            left: 5px;
            margin: 10px 0 10px 0px;
            padding: 7px;
            position: relative;
            right: 200px;
            width: 500px;
            height: 85px;
        }
        
        
        div.taskheader
        {
            float: left;
            left: 5px;
            margin: 10px 0 10px 0px;
            padding: 7px;
            position: relative;
            right: 200px;
            width: 500px;
        }
        div.taskcompleted
        {
            position: relative;
            float: left;
            margin: 10px 0 0;
            padding: 7px;
            padding-left: 20px;
            width: 100px;
        }
        div.tasktimeline
        {
            position: relative;
            float: left;
            margin: 10px 0 0;
            padding: 7px;
            width: 200px;
        }
        
        
        h2
        {
            color: #000;
            font-size: 16px;
            padding: 0px;
            margin: 0px;
        }
        
        .disabled
        {
            color: #cccccc;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script language="javascript" type="text/javascript">

        var tasks = <%=ViewBag.TaskDescriptions%>;

        $(function () {

            function EnableTaskCompleted(taskId, disable) {
                if (disable) {
                    $('.timeline_' + taskId).attr('disabled', 'disabled').addClass('disabled');
                } else {
                    $('.timeline_' + taskId).removeAttr('disabled', '').removeClass('disabled');
                }
            }

            $(".taskcompleted input:radio").change(function () {
                //var taskId = $(event.target).attr("taskid");
                 var taskId = $(this).attr("taskid");

                // Yes, they have completed, disable the timeline radio options
                if (this.value == "Yes") {
                    EnableTaskCompleted(taskId, true);
                } else {
                    EnableTaskCompleted(taskId, false);
                }
            });

            $(".dialoglink").click(function() {
                //var taskId = $(event.target).attr("taskid");
                var taskId = $(this).attr("taskid");
                                
                $("#dialog-message")
                    .html(tasks[taskId].Description)
                    .dialog({ 
                        modal: true,
                        width: 500,
                        title: tasks[taskId].ShortText,
                        resizable: false,
                        buttons: {
                                Ok: function() { $( this ).dialog( "close" );                                               }
                                    }
                          });
            });

        });

    </script>
    <div>
        <div class="taskheader">
            <h2>
                These are important tasks that we have identified for you to complete. Please read
                them carefully and answer the two following questions.</h2>
        </div>
        <div class="taskcompleted">
            <h2>
                Have you completed this task?</h2>
        </div>
        <div class="tasktimeline">
            <h2>
                If not, when do you plan to complete this task?</h2>
        </div>
    </div>
    <form action="/Assessment/<%:ViewBag.Domain %>/<%: ViewBag.Parent %>/<%: ViewBag.Page %>"
    method="post">
    <% foreach (var task in Model)
       {            
    %>
    <div class="task">
        <div class="tasktext">
            <%=(ViewBag.IsSelf) ? task.PromptTextSelf : task.PromptText %>
            <br />
            <div style="font-size: smaller; display: inline-block; cursor: help;">
                <a class="resource dialoglink" taskid="<%=task.TaskId %>">Learn more about this task</a></div>
        </div>
        <div class="taskcompleted">
            <input type="radio" name="TaskCompleted.<%=task.TaskId %>" taskid="<%=task.TaskId %>"
                value="Yes" <%=(task.Completed)?"checked='checked'":"" %> />Yes<br />
            <input type="radio" name="TaskCompleted.<%=task.TaskId %>" taskid="<%=task.TaskId %>"
                value="No" <%=(task.Completed)?"":"checked='checked'" %> />No
        </div>
        <div class="tasktimeline timeline_<%=task.TaskId %> <%=(task.Completed)?"disabled":"" %>">
            <input type="radio" name="TaskTimeline.<%=task.TaskId %>" class="timeline_<%=task.TaskId %>"
                value="1" <%=(task.Completed)?"disabled='disabled'":"" %> />Within 1 month<br />
            <input type="radio" name="TaskTimeline.<%=task.TaskId %>" class="timeline_<%=task.TaskId %>"
                value="2" <%=(task.Completed)?"disabled='disabled'":"" %> />Within 3 months<br />
            <input type="radio" name="TaskTimeline.<%=task.TaskId %>" class="timeline_<%=task.TaskId %>"
                value="3" <%=(task.Completed)?"disabled='disabled'":"" %> />Within 6 months<br />
            <input type="radio" name="TaskTimeline.<%=task.TaskId %>" class="timeline_<%=task.TaskId %>"
                value="4" <%=(task.Completed)?"disabled='disabled'":"" %> />Within 12 months<br />
            <input type="radio" name="TaskTimeline.<%=task.TaskId %>" class="timeline_<%=task.TaskId %>"
                value="5" <%=(task.Completed)?"disabled='disabled'":"" %> />12 months or longer
        </div>
    </div>
    <div style="visibility: hidden; height: 0px;" class="taskDetails" id="taskDetails.<%=task.TaskId %>">
        <%=(ViewBag.IsSelf) ? task.AssessmentTextSelf : task.AssessmentText %>
    </div>
    <%} // End looping through tasks %>
    <div>
        <div style="clear: both;">
        </div>
        <div class="bottom_nav">
            <div style="float: left;">
                <a href="/Assessment/<%:ViewBag.Domain %>/<%: ViewBag.Parent %>/<%: ViewBag.Page - 1 %>"
                    class="back">Back</a></div>
            <div class="rightnav">
                <input style="cursor: pointer;" type="submit" value="Save and Continue" />
            </div>
        </div>
    </div>
    </form>
    <div id="dialog-message" style="display: none;">
        test
    </div>
</asp:Content>
