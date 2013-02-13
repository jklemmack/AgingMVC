<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<AgingMVC.Models.User>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Parent Care Readiness : Home
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeaderContent" runat="server">
    <style type="text/css">
        #topwrapper
        {
        }
        
        #carerecipientlist
        {
            float: left;
            width: 150px;
            height: 100%;
        }
        
        
        #overview
        {
        height: 100%;
    margin-bottom: 0;
    margin-left: 200px;
        }
        
        #domains
        {
           height: 150px;
    margin-bottom: 20px;
    margin-left: 190px;
    width: 700px;
        }
        
        div .domain
        {
            width: 140px;
            height: 200px;
            float: left;
			text-align:center;
            margin: 5px;
        }
        
        .carerecipientselected
        {
             background-color: #961200;
    border-radius: 5px 5px 5px 5px;
    color: White;
    margin: 10px 0;
    padding: 10px;
        }
        
        div .bardivs
        {
            position: relative;
			 margin-bottom: 10px;
        }
        
        div .progresstext
        {
            width: 100%;
            position: absolute;
            top: 5px;
            text-align: center;
        }
    </style>
    <script language="javascript" type="text/javascript">
        
        var parentData = <%=ViewBag.ParentData %>
        var selectedParent = '';

        $(document).ready(function () {

            SetParentLinks($("#Parent").val());

            SetProgressBars();

            $("#Parent").change(function () {
                var parent = $("#Parent").val();
                SetParentLinks(parent);
            });
            
            <% if (ViewBag.FirstParent != null)
                 Response.Write(string.Format("NavigateToParent('{0}');", ViewBag.FirstParent));
            %>
        });

        function NavigateToParent(parent) {
            window.location.hash = parent;
            selectedParent = parent;
            SetParentLinks(parent);
            $('.carerecipientselected').each(function() { 
                $(this).removeClass('carerecipientselected'); 
                });
            $('#carerecipient[parent=' + parent + ']').addClass('carerecipientselected');


            var p = parentData[parent];
            $("#MedicalProgress").attr("progress", p.MedicalProgress);
            $("#LegalProgress").attr("progress", p.LegalProgress);
            $("#SocialProgress").attr("progress", p.SocialProgress);
            $("#EmotionalProgress").attr("progress", p.EmotionalProgress);

            SetProgressBars();
            SetProgressText();
        }

        function SetParentLinks(parent) {
            $("#Medical").attr("href", "/Assessment/Medical/" + parent);
            $("#Legal").attr("href", "/Assessment/Legal/" + parent);
            $("#Social").attr("href", "/Assessment/Social/" + parent);
            $("#Emotional").attr("href", "/Assessment/Emotional/" + parent);

            $("#MedicalResources").click(function() { window.location = "/Resources/" + selectedParent + "/Medical"; });
            $("#MedicalResources").css('cursor', 'pointer');

            $("#LegallResources").click(function() { window.location = "/Resources/" + selectedParent + "/Legal"; });
            $("#LegallResources").css('cursor', 'pointer');

            $("#SocialResources").click(function() { window.location = "/Resources/" + selectedParent + "/Social"; });
            $("#SociallResources").css('cursor', 'pointer');

            $("#EmotionalResources").click(function() { window.location = "/Resources/" + selectedParent + "/Emotional"; });
            $("#EmotionalResources").css('cursor', 'pointer');
        }

        function SetProgressBars() {
            $('.progressbar').each(function () {
                var value = parseInt($(this).attr('progress'));
                $(this).progressbar({ value: value });

            });
        }

        function SetProgressText(){
            $('.bardivs').each(function () {
                var value = parseInt($(this).find('.progressbar').attr('progress'));
                if (value == 100)
                {
                    //$(this).find('.progresstext').show();
                    $(this).find('.progresstext').html('View Resources');
                } else {
                    //$(this).find('.progresstext').hide();
                    $(this).find('.progresstext').html('Enter assessment');
                }
            });
        }


    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="heading">
        <h1>
            Overview</h1>
    </div>
    <div id="topwrapper">
        <fieldset id="carerecipientlist" style="min-height: 300px;">
            <legend>Care Recipients</legend>
            <%foreach (AgingMVC.Models.vw_ParentSummary parent in Model.ParentSummaries)
              {%>
            <div id="carerecipient" class="display-field" parent="<%:parent.FirstName %>" onclick="NavigateToParent('<%:parent.FirstName %>')"
                style="cursor: pointer;">
                <%: parent.FirstName %>
                <div style="position: relative;">
                    <div class="progressbar" progress="<%: 100 * ((float) parent.Completed) / parent.Total%>">
                    </div>
                    <div class="progresstext" style="color: Gray;">
                        <%: parent.Completed %>
                        of
                        <%: parent.Total %>
                        completed
                    </div>
                    <div style="width: 100%;">
                        <a href="/Parent/Edit/<%:parent.FirstName %>" style="color: White; font-size: small;
                            margin-top: 5px; text-align: center;">Recipient details</a></div>
                </div>
            </div>
            <%} %>
            <%: Html.ActionLink("Add new care recipient", "Create", "Parent") %>
        </fieldset>
        <fieldset id="overview">
            <p>
                Most often adults with elderly parents enter into caregiving with an abrupt, often
                medical-related, event such as a fall, stroke, or heart-attack. The caregivers are
                then caught between two lives: one where they respect and care for their elderly
                parents; and the own family life with a job, kids, and the normal demands of daily
                life. This can be a very stressful time for both the care giver and the care recipient.</p>
            <p>
                What is "Being Prepared"?<br />
                Just like entering puberty or having children, caring for an elderly loved one is
                a predictable life-stage event that can be anticipated and planned for.</p>
            <p>
                The PCRP Can Help<br />
                The Parent Care Readiness Program, or PCRP, is designed using the transtheoretical
                model of change, a proven model that helps people become informed, formulate a strategy,
                and act on a new, better behavior.</p>
        </fieldset>
    </div>
    <div id="domains">
        <div class="domain">
            <div class="bardivs" id="MedicalResources">
                <div class="progressbar" id="MedicalProgress">
                </div>
                <div class="progresstext">
                    <a>View Resources</a>
                </div>
            </div>
            <a name="Medical" id="Medical" href="/">
            <img src="/images/home_thumb_medical.jpg" width="116" alt="Link to Medical Assessment" /><br />
                Enter Medical Assessment</a>
        </div>
        <div class="domain">
            <div class="bardivs">
                <div class="progressbar" id="LegalProgress">
                </div>
                <div class="progresstext">
                    View Resources
                </div>
            </div>
            <a name="Legal" id="Legal" href="/">
            <img src="/images/home_thumb_legal.jpg" width="116" /><br />
                Enter Legal Assessment</a></div>
        <div class="domain" style="text-align: center;">
            <div class="bardivs">
                <div class="progressbar" id="SocialProgress">
                </div>
                <div class="progresstext">
                    View Resources
                </div>
            </div>
            <a name="Social" id="Social" href="/">
        <img src="/images/home_thumb_family.jpg" width="115" /><br />
                Enter Social Assessment</a></div>
        <div class="domain">
            <div class="bardivs">
                <div class="progressbar" id="EmotionalProgress">
                </div>
                <div class="progresstext">
                    View Resources
                </div>
            </div>
            <a name="Emotional" id="Emotional" href="/">
            <img src="/images/home_thumb_emotional.jpg" width="115" /><br />
                Enter Emotional Assessment</a></div>
    </div>
</asp:Content>
