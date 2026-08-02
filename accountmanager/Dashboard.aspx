<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Dashboard.aspx.cs"
    Inherits="accountmanager.Dashboard" %>

<%@ Register
    Src="~/Controls/Navigation.ascx"
    TagPrefix="bb"
    TagName="Navigation" %>

<!DOCTYPE html>

<html>
<head runat="server">

    <title>Dashboard | Byte Builders</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1" />

    <link href="Styles/site.css"
          rel="stylesheet"
          type="text/css" />

</head>

<body>

<form id="form1" runat="server">

    <bb:Navigation
        ID="Navigation1"
        runat="server" />

    <main class="dashboard-page">

        <section class="dashboard-heading">

            <div class="form-eyebrow">
                Byte Builders Workspace
            </div>

            <h1>
                Your Dashboard
            </h1>

            <p>
                Choose an action based on your assigned role.
            </p>

        </section>

        <asp:Label
            ID="lblDashboardMessage"
            runat="server"
            CssClass="message dashboard-message" />

        <div class="dashboard-grid">

            <!-- ===================================================== -->
            <!-- EMPLOYEE -->
            <!-- ===================================================== -->

            <asp:Panel
                ID="pnlEmployee"
                runat="server"
                CssClass="dashboard-panel"
                Visible="false">

                <a href="SubmitProposal.aspx"
                   class="dashboard-card">

                    <div class="dashboard-card-icon">01</div>

                    <div class="dashboard-card-content">

                        <span class="dashboard-card-label">
                            Employee
                        </span>

                        <h2>Submit Proposal</h2>

                        <p>
                            Submit a workplace proposal to an active
                            concern group.
                        </p>

                    </div>


                </a>


                <a href="ProposalStatus.aspx"
                   class="dashboard-card">

                    <div class="dashboard-card-icon">02</div>

                    <div class="dashboard-card-content">

                        <span class="dashboard-card-label">
                            Proposals
                        </span>

                        <h2>View Proposal Status</h2>

                        <p>
                            Track the current progress of your
                            submitted proposals.
                        </p>

                    </div>


                </a>

            </asp:Panel>


            <!-- ===================================================== -->
            <!-- MANAGER -->
            <!-- ===================================================== -->

            <asp:Panel
                ID="pnlManager"
                runat="server"
                CssClass="dashboard-panel"
                Visible="false">

                <a href="SubmitConcernGroup.aspx"
                   class="dashboard-card">

                    <div class="dashboard-card-icon">01</div>

                    <div class="dashboard-card-content">

                        <span class="dashboard-card-label">
                            Manager
                        </span>

                        <h2>Create Concern Group</h2>

                        <p>
                            Create new concern groups available for
                            employee proposals.
                        </p>

                    </div>

 
                </a>


                <a href="ViewGroupDetails.aspx"
                   class="dashboard-card">

                    <div class="dashboard-card-icon">02</div>

                    <div class="dashboard-card-content">

                        <span class="dashboard-card-label">
                            Manager
                        </span>

                        <h2>View Concern Groups</h2>

                        <p>
                            View all concern groups along with the
                            manager who created each one.
                        </p>

                    </div>


                </a>


                <a href="SubmittedProposals.aspx"
                   class="dashboard-card">

                    <div class="dashboard-card-icon">03</div>

                    <div class="dashboard-card-content">

                        <span class="dashboard-card-label">
                            Manager
                        </span>

                        <h2>View Submitted Proposals</h2>

                        <p>
                            Review every proposal submitted by
                            employees.
                        </p>

                    </div>


                </a>


                <a href="ProposalStatus.aspx"
                   class="dashboard-card">

                    <div class="dashboard-card-icon">04</div>

                    <div class="dashboard-card-content">

                        <span class="dashboard-card-label">
                            Proposals
                        </span>

                        <h2>View Proposal Status</h2>

                        <p>
                            View proposal status, progress and
                            workflow updates.
                        </p>

                    </div>


                </a>


                <a href="UpdateProposalStatus.aspx"
                   class="dashboard-card">

                    <div class="dashboard-card-icon">05</div>

                    <div class="dashboard-card-content">

                        <span class="dashboard-card-label">
                            Manager
                        </span>

                        <h2>Update Proposal Status</h2>

                        <p>
                            Approve, reject or update proposal
                            progress.
                        </p>

                    </div>


                </a>

            </asp:Panel>


            <!-- ===================================================== -->
            <!-- ADMIN -->
            <!-- ===================================================== -->

            <asp:Panel
                ID="pnlAdmin"
                runat="server"
                CssClass="dashboard-panel"
                Visible="false">

                <a href="ManageUsers.aspx"
                   class="dashboard-card dashboard-card-admin">

                    <div class="dashboard-card-icon">01</div>

                    <div class="dashboard-card-content">

                        <span class="dashboard-card-label">
                            Administration
                        </span>

                        <h2>Manage Users</h2>

                        <p>
                            Promote Employees to Managers and manage
                            user permissions.
                        </p>

                    </div>


                </a>

            </asp:Panel>

        </div>

    </main>

</form>

</body>
</html>