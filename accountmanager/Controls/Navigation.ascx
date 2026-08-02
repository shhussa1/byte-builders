<%@ Control Language="C#" AutoEventWireup="true"
    CodeBehind="Navigation.ascx.cs"
    Inherits="accountmanager.Controls.Navigation" %>

<header class="app-nav">

    <a href="<%= ResolveUrl("~/Dashboard.aspx") %>"
       class="app-nav-brand">

        <img
            src="<%= ResolveUrl("~/Images/byte-builders-b-v3.png") %>"
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


    <nav class="app-menu">

        <a href="<%= ResolveUrl("~/Dashboard.aspx") %>">
            Dashboard
        </a>


        <asp:Panel
            ID="pnlEmployeeMenu"
            runat="server"
            CssClass="nav-panel"
            Visible="false">

            <a href="<%= ResolveUrl("~/SubmitProposal.aspx") %>">
                Submit Proposal
            </a>

            <a href="<%= ResolveUrl("~/ProposalStatus.aspx") %>">
                Proposal Status
            </a>

        </asp:Panel>


        <asp:Panel
            ID="pnlManagerMenu"
            runat="server"
            CssClass="nav-panel"
            Visible="false">

            <a href="<%= ResolveUrl("~/SubmitConcernGroup.aspx") %>">
                Create Concern Group
            </a>

            <a href="<%= ResolveUrl("~/SubmittedProposals.aspx") %>">
                Submitted Proposals
            </a>

            <a href="<%= ResolveUrl("~/UpdateProposalStatus.aspx") %>">
                Update Status
            </a>

            <a href="<%= ResolveUrl("~/ProposalStatus.aspx") %>">
                Proposal Status
            </a>

        </asp:Panel>


        <asp:Panel
            ID="pnlAdminMenu"
            runat="server"
            CssClass="nav-panel"
            Visible="false">

            <a href="<%= ResolveUrl("~/ManageUsers.aspx") %>">
                Manage Users
            </a>

            <a href="<%= ResolveUrl("~/SubmitConcernGroup.aspx") %>">
                Create Concern Group
            </a>

        </asp:Panel>


        <span class="nav-user">

            <asp:Literal
                ID="litUserName"
                runat="server" />

            <span class="nav-role">

                <asp:Literal
                    ID="litRole"
                    runat="server" />

            </span>

        </span>


        <a href="<%= ResolveUrl("~/Logout.aspx") %>"
           class="nav-logout">
            Sign out
        </a>

    </nav>

</header>