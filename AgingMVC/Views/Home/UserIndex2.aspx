<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<AgingMVC.Models.User>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    AgeReady : Home
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="heading">
        <h1>
            Overview</h1>
    </div>
    <div id="steps">
        <div class="stepcontainer">
            <span class="step">Step 1:</span>Select a care recipient</div>
        <div class="stepcontainer">
            <span class="step">Step 2:</span>Complete the evaluation</div>
        <div class="stepcontainer">
            <span class="step">Step 3:</span>Access resources to help you complete the most
            important tasks that are identified in each domain</div>
    </div>
    <div id="recipientoutercontainer">
        <!-- currently selected user - background red/crimson  -->
        <div id="activerecipient">
            <div class="carename">
                Person name</div>
            Readiness Meter
            <div class="progressbar" id="user1">
            </div>
            <!--  -->
        </div>
        <div id="recipientcarousel">
        </div>
    </div>
    <div id="assessmentcontainer">
        <div id="medicalassessment">
        Medical
        </div>
        <div id="legalassessment">Legal and Financial
        </div>
        <div id="familyassessment">Family and Social
        </div>
        <div id="spiritualassessment">Spiritual and Emotional
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
</asp:Content>
