HtmlTableAsSpreadSheet - Apply some rudimentary spreadsheet-like functions to an HTML table
===========================================================================================

Features
--------
HtmlTableAsSpreadSheet is a jQuery plugin that is intended to take a number orientatated HTML table and apply instructions to create a rudimentary spreadsheet-like table.


Create a table and apply the Plug-in
------------------------------------

```html
<table id="Mine2">
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
	.
	.
	.
	
</table>
```

```js
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

});
function refreshTable() {
	$("#Mine2").htmlTableToSpreadSheet('process');
}
```

or
```js
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
	});}
```

Usage
-----
Instructions can be passed into the plug-in using JSON. Gerneally this involves specifying two source cells and an output cell e.g.
```js
{ inputCells: ["C2", "D2"], operator: function (x, y) { return x * y; }, outputCell: "E2" }
```
More complicated instructions can be chained together through the use of temporary stores prefixed by '!' e.g.
```js
{ inputCells: ["B2", "C2"], operator: function (x, y) { return x * y; }, outputCell: "!C2" }
```
The above example takes two real cells and places the result in a variable '!C2'. This variable can then be used as part of an instruction e.g.
```js
{ inputCells: ["!C2", "D2"], operator: function (x, y) { return x - y; }, outputCell: "D2" }
```

Method
------
The jQuery plugin was built using "websanova/boilerplate" template available on Git.


Limitations and caveats
-----------------------
First attempt at jQuery plug-in with some not-very-strong Javascript. HTML tables should be flat with consistent number of columns per row. Currently there is no way to specify generic formulae for all columns or rows, for example ["C","D"]. Error-handling is a dream yet to be realised. Solution is in VS2012 but does not depend on it.

Author
------
Gareth N. Case 