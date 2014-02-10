﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<AgingMVC.Models.Resource>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Index</h2>
    State Filter
        <%: Html.DropDownList("SelectedState",
                new SelectList(ViewBag.States, "StateCode", "StateName", ViewBag.SelectedState),
                new { onchange=@"window.location.href = window.location.href" }
                )
        %>
    <p>
        <%: Html.ActionLink("Create New", "Create") %>
    </p>
    <table>
        <tr>
            <th>Name
            </th>
            <th>ResourceState
            </th>
            <th></th>
        </tr>

        <% foreach (var item in Model)
           { %>
        <tr>
            <td>
                <%: Html.DisplayFor(modelItem => item.Name) %>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.ResourceState) %>
            </td>
            <td>
                <%: Html.ActionLink("Edit", "Edit", new { id=item.ResourceID }) %> |
                <%: Html.ActionLink("Details", "Details", new { id=item.ResourceID }) %> |
                <%: Html.ActionLink("Delete", "Delete", new { id=item.ResourceID }) %>
            </td>
        </tr>
        <% } %>
    </table>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeaderContent" runat="server">
</asp:Content>