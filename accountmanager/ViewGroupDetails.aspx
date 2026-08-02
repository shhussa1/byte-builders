<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="ViewGroupDetails.aspx.cs"
    Inherits="accountmanager.ViewGroupDetails" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Concern Group Details</title>

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

        th,
        td {
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

        <h1>Concern Group Details</h1>

        <p class="subtitle">
            View existing concern groups and their current information.
        </p>

        <asp:GridView
            ID="gvGroups"
            runat="server"
            AutoGenerateColumns="False"
            Width="100%"
            GridLines="None">

            <Columns>

                <asp:BoundField
                    DataField="concern_group_id"
                    HeaderText="Group ID" />

                <asp:BoundField
                    DataField="concern_group_name"
                    HeaderText="Group Name" />

                <asp:BoundField
                    DataField="concern_group_description"
                    HeaderText="Description" />

                <asp:BoundField
                    DataField="status"
                    HeaderText="Status"
                    ItemStyle-CssClass="status" />

                <asp:BoundField
                    DataField="created_by"
                    HeaderText="Created By" />

                <asp:BoundField
                    DataField="created_at"
                    HeaderText="Created At"
                    DataFormatString="{0:MM/dd/yyyy HH:mm}" />

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