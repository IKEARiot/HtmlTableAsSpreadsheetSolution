
(function ($) {
    $.fn.htmlTableToSpreadSheet = function (option, settings) {
        if (typeof option === 'object') {
            settings = option;
        }
        else if (typeof option === 'string') {
            var values = [];

            var elements = this.each(function () {
                var data = $(this).data('_htmlTableToSpreadSheet');

                if (data) {
                    if (option === 'reset') { data.reset(); }
                    else if (option === 'process') {
                        data.process();
                    }
                    else if ($.fn.htmlTableToSpreadSheet.defaultSettings[option] !== undefined) {
                        if (settings !== undefined) { data.settings[option] = settings; }
                        else { values.push(data.settings[option]); }
                    }
                }
            });

            if (values.length === 1) { return values[0]; }
            if (values.length > 0) { return values; }
            else { return elements; }
        }

        return this.each(function () {
            var $elem = $(this);
            var $settings = $.extend({}, $.fn.htmlTableToSpreadSheet.defaultSettings, settings || {});
            var myhtmlTableToSpreadSheet = new HtmlTableToSpreadSheet($settings, $elem);
            var $el = myhtmlTableToSpreadSheet.generate();
            $('body').append($el);
            $elem.data('_htmlTableToSpreadSheet', myhtmlTableToSpreadSheet);
        });
    }

    $.fn.htmlTableToSpreadSheet.defaultSettings = {        
    };

    function cellContent(thisCell) {

        if (thisCell.children.length > 0) {
            return thisCell.children[0];
        }
        else {
            return thisCell;
        }
    }

    function GetValueFromCell(thisCell) {
        var curVal = 0;
        if (thisCell.children.length > 0) {
            curVal = parseFloat(thisCell.children[0].innerHTML);
            if (isNaN(curVal)) {
                curVal = parseFloat(thisCell.children[0].value);
            }
        } else {
            if (thisCell.firstChild != null) {
                curVal = parseFloat(thisCell.firstChild.data);
            }
        }

        if (!isNaN(curVal)) {
            return curVal;
        } else {
            return 0;
        }
    }

    function PaintTable(instructions, thisTable, outputTable) {

        for (var i = 0; i < instructions.length; i++) {
            var thisInstruction = instructions[i];

            var cell3 = thisInstruction.outputCell;
            var realIndexAtCell3 = GetRealIndexFromCell(cell3);
                        
            var row = outputTable.rows[realIndexAtCell3.y];
            var cellLength = row.cells.length;
            
            var cell = row.cells[realIndexAtCell3.x];
            if (cell.children.length > 0) {
                cell.children[0].innerHTML = thisTable[realIndexAtCell3.x][realIndexAtCell3.y];
            }
            else {
                cell.innerHTML = thisTable[realIndexAtCell3.x][realIndexAtCell3.y];
            }
        }
    }

    function ProcessInstruction(instruction, thisTable) {
        var result =  0;        
        var i = 0;
        for (var i = 0; i < instruction.inputCells.length; i++) {

            var cell1 = instruction.inputCells[i];
            var realIndexAtCell1 = GetRealIndexFromCell(cell1);
            var valueAtCell1 = parseFloat(thisTable[realIndexAtCell1.x][realIndexAtCell1.y]);

            if (i == 0) {
                result = valueAtCell1;
            }
            else {
                result = instruction.operator(result, valueAtCell1);
            }
        }
       
        var cell3 = instruction.outputCell;
        var realIndexAtCell3 = GetRealIndexFromCell(cell3);

        thisTable[realIndexAtCell3.x][realIndexAtCell3.y] = result;
    }

    function GetRealIndexFromCell(cell) {
        var column = ExtractColumn(cell);
        var row = ExtractRow(cell);
        var columnAsNumber = GetColumnsAsNumber(column);
        var rowAsNumber = GetRowAsNumber(row);
        return { x: columnAsNumber - 1, y: rowAsNumber - 1 };
    }

    function GetRowAsNumber(row) {
        var result = parseInt(row);
        if (isNaN(result)) {
            return 0;
        }
        else {
            return result;
        }
    }

    function GetColumnsAsNumber(column)
    {
        var base = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', i, j, result = 0;
        for (i = 0, j = column.length - 1; i < column.length; i += 1, j -= 1) {
            result += Math.pow(base.length, j) * (base.indexOf(column[i]) + 1);
        }
        return result;
    }

    function ExtractColumn(cell)
    {
        var result = "";
        for (var i = 0; i < cell.length; i++) {
            var char = cell[i];
            if (isNaN(char))
            {
                result = result.concat(char);
            }
        }
        return result;
    }

    function ExtractRow(cell) {
        var result = "";
        for (var i = 0; i < cell.length; i++) {
            var char = cell[i];
            if (!isNaN(char)) {
                result = result.concat(char);
            }
        }
        return result;
    }

    function CreateInternalRepresentation(table)
    {
        var rowLength = table.rows.length;
        var colLength = table.rows[0].cells.length;
       
        var result = [];
        for (var x = 0; x < colLength; x++) {
            result[x] = [];
            for (var y = 0; y < rowLength; y++) {
                result[x][y] = 0;
            }
        }

        for (var i = 0; i < rowLength; i += 1) {            
            var row = table.rows[i];
            var cellLength = row.cells.length;
            for (var y = 0; y < cellLength; y += 1) {
                var cell = row.cells[y];
                result[y][i] = GetValueFromCell(cell);               
            }
        }

        return result;
    }

    function HtmlTableToSpreadSheet(settings, $elem) {
        this.myhtmlTableToSpreadSheet = null;
        this.settings = settings;
        this.$elem = $elem;
        this.internalTable = null;
        return this;
    }

    HtmlTableToSpreadSheet.prototype =
	{
	    generate: function () {
	        var $this = this;
	        if ($this.myhtmlTableToSpreadSheet) return $this.myhtmlTableToSpreadSheet;
	        $this.myhtmlTableToSpreadSheet = $('<div class="_HtmlTableToSpreadSheet_holder"></div>');
	        $this.reset();
	        return $this.myhtmlTableToSpreadSheet;
	    },
	    reset: function () {
	        this.process();
	    },

	    process: function () {
	        var mytable = this.$elem[0];
	        this.internalTable = CreateInternalRepresentation(mytable);
	        var instructions = this.settings.instructions;

	        for (var i = 0; i < instructions.length; i++) {
	            ProcessInstruction(instructions[i], this.internalTable);
	        }
	     
	        PaintTable(instructions, this.internalTable, mytable);
	    }
	}
})(jQuery);

