<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<AgingMVC.Models.Task>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Index
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Index</h2>
    <p>
        <%: Html.ActionLink("Create New", "Create") %>
    </p>
    <table>
        <tr>
            <th>
                Domain
            </th>
            <th>
                Order
            </th>
            <th>
                Task Summary
            </th>
            <th>
                Task Description
            </th>
            <th style="width: 55px;">
            </th>
        </tr>
        <% foreach (var item in Model)
           { %>
        <tr>
            <td>
                <%: Html.DisplayFor(modelItem => item.Domain.ShortName) %>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.TaskOrder) %>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.ShortText) %>
            </td>
            <td>
                <%--<%: Html.DisplayFor(modelItem => item.PromptText) %>--%>
                <%: Html.Raw(item.PromptText) %>
            </td>
            <td>
                <%: Html.ActionLink("Edit", "Edit", new { id=item.TaskId }) %>
            </td>
        </tr>
        <% } %>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
</asp:Content>
