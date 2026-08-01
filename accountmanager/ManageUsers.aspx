<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="ManageUsers.aspx.cs"
    Inherits="accountmanager.ManageUsers" %>

<!DOCTYPE html>

<html>
<head runat="server">

    <title>Manage Users | Byte Builders</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1" />

    <link href="Styles/site.css"
          rel="stylesheet"
          type="text/css" />

</head>

<body>

<form id="form1" runat="server">

    <header class="app-nav">

        <a href="Dashboard.aspx"
           class="app-nav-brand">

            <img
                src="Images/byte-builders-b.png"
                alt="Byte Builders" />

            <div class="dashboard-brand-text">

                <span class="dashboard-brand-byte">
                    BYTE
                </span>

                <span class="dashboard-brand-builders">
                    BUILDERS
                </span>

            </div>

        </a>


        <nav class="admin-nav-links">

            <a href="Dashboard.aspx">
                Dashboard
            </a>

            <a href="ManageUsers.aspx"
               class="active-nav-link">
                Manage Users
            </a>

            <a href="Logout.aspx">
                Sign out
            </a>

        </nav>

    </header>


    <main class="app-page">

        <section class="management-header">

            <div>

                <div class="form-eyebrow">
                    Administration
                </div>

                <h1 class="management-title">
                    Manage users
                </h1>

                <p class="management-subtitle">
                    Assign registered users as Employees or Managers.
                </p>

            </div>

            <div class="admin-badge">
                Admin access
            </div>

        </section>


        <asp:Label
            ID="lblMessage"
            runat="server"
            CssClass="message management-message" />


        <section class="app-card user-table-card">

            <asp:GridView
                ID="gvUsers"
                runat="server"
                AutoGenerateColumns="False"
                DataKeyNames="user_id"
                CssClass="user-grid"
                GridLines="None"
                EmptyDataText="No Employee or Manager accounts were found."
                OnRowCommand="gvUsers_RowCommand">

                <Columns>

                    <asp:BoundField
                        DataField="user_id"
                        HeaderText="ID" />

                    <asp:BoundField
                        DataField="full_name"
                        HeaderText="Name" />

                    <asp:BoundField
                        DataField="email"
                        HeaderText="Email" />


                    <asp:TemplateField HeaderText="Current role">

                        <ItemTemplate>

                            <span class='role-badge role-<%# Eval("role").ToString().ToLowerInvariant() %>'>

                                <%# Eval("role") %>

                            </span>

                        </ItemTemplate>

                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Assign role">

                        <ItemTemplate>

                            <asp:DropDownList
                                ID="ddlRole"
                                runat="server"
                                CssClass="role-select"
                                SelectedValue='<%# Bind("role") %>'>

                                <asp:ListItem
                                    Text="Employee"
                                    Value="Employee" />

                                <asp:ListItem
                                    Text="Manager"
                                    Value="Manager" />

                            </asp:DropDownList>

                        </ItemTemplate>

                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Action">

                        <ItemTemplate>

                            <asp:Button
                                ID="btnUpdateRole"
                                runat="server"
                                Text="Update role"
                                CssClass="table-action-button"
                                CommandName="UpdateRole"
                                CommandArgument='<%# Container.DataItemIndex %>' />

                        </ItemTemplate>

                    </asp:TemplateField>

                </Columns>

            </asp:GridView>

        </section>

    </main>

</form>

</body>
</html>