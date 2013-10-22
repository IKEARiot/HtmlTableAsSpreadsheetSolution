<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="HtmlTableAsSpreadsheet.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-2.0.3.js"></script>
    <script src="Scripts/HtmlTableToSpreadSheet.js"></script>
    <link href="StyleSheet1.css" rel="stylesheet" />
    <script>
        $(document).ready(function () {
            $("#Mine2").htmlTableToSpreadSheet({
                instructions: [{ inputCells: ["C2", "D2"], operator: function (x, y) { return x * y; }, outputCell: "E2" },
                            { inputCells: ["C3", "D3"], operator: function (x, y) { return x + y; }, outputCell: "E3" },
                            { inputCells: ["C4", "D4"], operator: function (x, y) { return x - y; }, outputCell: "E4" },
                            { inputCells: ["C5", "D5"], operator: function (x, y) { return x / y; }, outputCell: "E5" },
                            { inputCells: ["C2", "C3", "C4", "C5"], operator: function (x, y) { return x + y; }, outputCell: "C6" },
                            { inputCells: ["D2", "D3", "D4", "D5"], operator: function (x, y) { return x + y; }, outputCell: "D6" },
                            { inputCells: ["C6", "D6"], operator: function (x, y) { return x + y; }, outputCell: "E6" }]
            });

            $("#Mine3").htmlTableToSpreadSheet({
                instructions: [{ inputCells: ["B2", "C2"], operator: function (x, y) { return x * y; }, outputCell: "!C2" },
                            { inputCells: ["!C2", "D2"], operator: function (x, y) { return x - y; }, outputCell: "!D2" },
                            { inputCells: ["!D2", "E2"], operator: function (x, y) { return x + y; }, outputCell: "!E2" },
                            { inputCells: ["!E2", "F2"], operator: function (x, y) { return x - y; }, outputCell: "!F2" },
                            { inputCells: ["!F2", "G2"], operator: function (x, y) { return x - y; }, outputCell: "H2" },
                            { inputCells: ["B3", "C3"], operator: function (x, y) { return x * y; }, outputCell: "!C3" },
                            { inputCells: ["!C3", "D3"], operator: function (x, y) { return x - y; }, outputCell: "!D3" },
                            { inputCells: ["!D3", "E3"], operator: function (x, y) { return x + y; }, outputCell: "!E3" },
                            { inputCells: ["!E3", "F3"], operator: function (x, y) { return x - y; }, outputCell: "!F3" },
                            { inputCells: ["!F3", "G3"], operator: function (x, y) { return x - y; }, outputCell: "H3" }
                           ]
            });

        });
        function refreshTable() {
            $("#Mine2").htmlTableToSpreadSheet('process');
            $("#Mine3").htmlTableToSpreadSheet('process');
        }
</script>
   
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table id="Mine2" class="MineClass">
            <tr>
                <td>Test</td>
                <td></td>
                <td>Qty</td>
                <td>Qty2</td>
                <td>Total</td>
                <td>Formula</td>
            </tr>
            <tr>
                <td>Item1</td>
                <td></td>
                <td>
                    <asp:TextBox ID="TextBox4" runat="server" onchange="refreshTable();"></asp:TextBox>                                
                </td>
                <td>
                    <asp:TextBox ID="TextBox5" runat="server" onchange="refreshTable();"></asp:TextBox>                                
                </td>
                <td>
                    <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>
                </td>
                <td>return x * y</td>
            </tr>
            <tr>
                <td>Item2</td>
                <td></td>
                <td>
                    <asp:TextBox ID="TextBox6" runat="server" onchange="refreshTable();"></asp:TextBox>                                
                </td>
                <td>
                    <asp:TextBox ID="TextBox7" runat="server" onchange="refreshTable();"></asp:TextBox>                                
                </td>
                <td>
                    <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>
                </td>
                <td>return x + y;</td>
            </tr>
            <tr>
                <td>Item3</td>
                <td></td>
                <td>
                    <asp:TextBox ID="TextBox8" runat="server" onchange="refreshTable();"></asp:TextBox>                                
                </td>
                <td>
                    <asp:TextBox ID="TextBox9" runat="server" onchange="refreshTable();"></asp:TextBox>                                
                </td>
                <td>
                    <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>
                </td>
                <td>return x - y;</td>
            </tr>
            <tr>
                <td>Item4</td>
                <td></td>
                <td>
                    <asp:TextBox ID="TextBox10" runat="server" onchange="refreshTable();"></asp:TextBox>                                
                </td>
                <td>
                    <asp:TextBox ID="TextBox11" runat="server" onchange="refreshTable();"></asp:TextBox>                                
                </td>
                <td>
                    <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>
                </td>
                <td>return x / y;</td>
            </tr>

            <tr>
                <td>Tots</td>
                <td>&nbsp;</td>
                <td>
                    <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="Label10" runat="server" Text="Label"></asp:Label>
                </td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td>&nbsp;</td>
                <td>                    
                    return x + y</td>
                <td>                    
                    return x + y</td>
                <td>                    
                </td>
                <td></td>
            </tr>
        </table>
    </div>
        <div>
            <table id="Mine3" class="MineClass">
                <thead>

                </thead>
                <tbody>
                    <tr>
                        <td>
                    <asp:Label ID="Label12" runat="server" Text="30"></asp:Label>
                        </td>
                        <td>b</td>
                        <td>c</td>
                        <td>d</td>
                        <td>e</td>
                        <td>f</td>
                        <td>g</td>
                        <td>tot</td>
                    </tr>
                    <tr>
                        <td ></td>
                        <td >
                           <asp:TextBox ID="TextBox1" runat="server" onchange="refreshTable();"></asp:TextBox>  
                        </td>
                        <td >
                            <asp:TextBox ID="TextBox2" runat="server" onchange="refreshTable();"></asp:TextBox>  
                        </td>
                        <td >
                    <asp:Label ID="Label11" runat="server" Text="30"></asp:Label>
                        </td>
                        <td >
                            <asp:TextBox ID="TextBox12" runat="server" onchange="refreshTable();"></asp:TextBox>  
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox13" runat="server" onchange="refreshTable();"></asp:TextBox>  
                        </td>
                        <td >
                            60</td>
                        <td >0</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>10</td>
                        <td>20</td>
                        <td>30</td>
                        <td>40</td>
                        <td>50</td>
                        <td>60</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>&nbsp;</td>                        
                    </tr>
                </tbody>
                <tfoot>

                </tfoot>
                
            </table>

        </div>
    </form>
</body>
    
</html>
