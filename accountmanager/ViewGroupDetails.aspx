<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="ProposalStatus.aspx.cs"
    Inherits="accountmanager.ProposalStatus" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Proposal Status</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 40px;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
        }

        h1 {
            margin-bottom: 10px;
        }

        .subtitle {
            color: #666;
            margin-bottom: 25px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 14px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #2f4858;
            color: white;
        }

        tr:hover {
            background-color: #f8f8f8;
        }

        .status {
            font-weight: bold;
        }
    </style>
</head>

<body>

<form id="form1" runat="server">

    <div class="container">

        <h1>Proposal Status</h1>

        <p class="subtitle">
            View the current status of workplace proposals submitted to management.
        </p>

        <asp:GridView
            ID="gvProposals"
            runat="server"
            AutoGenerateColumns="False"
            Width="100%"
            GridLines="None">

            <Columns>

                <asp:BoundField
                    DataField="proposal_id"
                    HeaderText="Proposal ID" />

                <asp:BoundField
                    DataField="title"
                    HeaderText="Proposal" />

                <asp:BoundField
                    DataField="description"
                    HeaderText="Description" />

                <asp:BoundField
                    DataField="status"
                    HeaderText="Status"
                    ItemStyle-CssClass="status" />

            </Columns>

        </asp:GridView>

        <asp:Label
            ID="lblMessage"
            runat="server">
        </asp:Label>

    </div>

</form>

</body>
</html>