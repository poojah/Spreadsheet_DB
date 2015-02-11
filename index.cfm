<!--- Please insert your code here --->
	<cfset datasrc="cfartgallery">
	<cfset SpreadsheetObj = spreadsheetNew(#datasrc#)>
	<cfdbinfo datasource="#datasrc#" type="tables" name="getTables">
	<cfloop query="getTables">
		<cfif left(getTables.TABLE_NAME, 3) NEQ 'SYS'>
			<cfscript>
				SpreadsheetSetActiveSheet(SpreadsheetObj,datasrc);
				spreadsheetAddRow(SpreadsheetObj,getTables.TABLE_NAME);
				SpreadSheetcreateSheet(SpreadsheetObj,getTables.TABLE_NAME);
				SpreadsheetSetActiveSheet(SpreadsheetObj,getTables.TABLE_NAME);
			</cfscript>
			<cfdbinfo datasource="#datasrc#" name="getColumns" type="columns" table="#getTables.TABLE_NAME#" />
			<cfset str="">
			<cfloop query="getColumns">
				<cfset str = str & getColumns.COLUMN_NAME & ",">
			</cfloop>
			<cfscript>
				spreadsheetAddRow(SpreadsheetObj,str);
			</cfscript>
			<cfquery datasource="#datasrc#" name="rowEntries" result="res">
				SELECT * from #getTables.TABLE_NAME#
		    </cfquery>
		   <!---<cfloop query="rowEntries">
		    	<cfscript>
		    		spreadsheetAddRow(SpreadsheetObj,rowEntries);
		       </cfscript>
		    </cfloop>--->
		    <cfloop query="rowEntries">
		    	<cfset str="">
		    	<cfloop list="#ArrayToList(rowEntries.getColumnNames())#" index="col">
					<cfset str = str & #rowEntries[col][currentrow]# & ",">
				</cfloop>
				<cfscript>
    			 	spreadsheetAddRow(SpreadsheetObj,str); 
			    </cfscript>
		    </cfloop>
		    <cfdump var="#rowEntries#" >
	    </cfif>
	</cfloop>	


<cfspreadsheet action="write" filename="C:\Users\vadiraja\Documents\xmldoc.xls" name="SpreadsheetObj" overwrite=true>
