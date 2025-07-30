### String Data Types

|Data type|Description|
|---|---|
|CHAR(size)|A FIXED length string (can contain letters, numbers, and special characters). The _size_ parameter specifies the column length in characters - can be from 0 to 255. Default is 1|
|VARCHAR(size)|A VARIABLE length string (can contain letters, numbers, and special characters). The _size_ parameter specifies the maximum string length in characters - can be from 0 to 65535|
|BINARY(size)|Equal to CHAR(), but stores binary byte strings. The _size_ parameter specifies the column length in bytes. Default is 1|
|VARBINARY(size)|Equal to VARCHAR(), but stores binary byte strings. The _size_ parameter specifies the maximum column length in bytes.|
|TINYBLOB|For BLOBs (Binary Large Objects). Max length: 255 bytes|
|TINYTEXT|Holds a string with a maximum length of 255 characters|
|TEXT(size)|Holds a string with a maximum length of 65,535 bytes|
|BLOB(size)|For BLOBs (Binary Large Objects). Holds up to 65,535 bytes of data|
|MEDIUMTEXT|Holds a string with a maximum length of 16,777,215 characters|
|MEDIUMBLOB|For BLOBs (Binary Large Objects). Holds up to 16,777,215 bytes of data|
|LONGTEXT|Holds a string with a maximum length of 4,294,967,295 characters|
|LONGBLOB|For BLOBs (Binary Large Objects). Holds up to 4,294,967,295 bytes of data|
|ENUM(val1, val2, val3, ...)|A string object that can have only one value, chosen from a list of possible values. You can list up to 65535 values in an ENUM list. If a value is inserted that is not in the list, a blank value will be inserted. The values are sorted in the order you enter them|
|SET(val1, val2, val3, ...)|A string object that can have 0 or more values, chosen from a list of possible values. You can list up to 64 values in a SET list|

### Numeric Data Types

|Data type|Description|
|---|---|
|BIT(_size_)|A bit-value type. The number of bits per value is specified in _size_. The _size_ parameter can hold a value from 1 to 64. The default value for _size_ is 1.|
|TINYINT(_size_)|A very small integer. Signed range is from -128 to 127. Unsigned range is from 0 to 255. The _size_ parameter specifies the maximum display width (which is 255)|
|BOOL|Zero is considered as false, nonzero values are considered as true.|
|BOOLEAN|Equal to BOOL|
|SMALLINT(_size_)|A small integer. Signed range is from -32768 to 32767. Unsigned range is from 0 to 65535. The _size_ parameter specifies the maximum display width (which is 255)|
|MEDIUMINT(_size_)|A medium integer. Signed range is from -8388608 to 8388607. Unsigned range is from 0 to 16777215. The _size_ parameter specifies the maximum display width (which is 255)|
|INT(_size_)|A medium integer. Signed range is from -2147483648 to 2147483647. Unsigned range is from 0 to 4294967295. The _size_ parameter specifies the maximum display width (which is 255)|
|INTEGER(_size_)|Equal to INT(size)|
|BIGINT(_size_)|A large integer. Signed range is from -9223372036854775808 to 9223372036854775807. Unsigned range is from 0 to 18446744073709551615. The _size_ parameter specifies the maximum display width (which is 255)|
|FLOAT(_size_, _d_)|A floating point number. The total number of digits is specified in _size_. The number of digits after the decimal point is specified in the _d_ parameter. This syntax is deprecated in MySQL 8.0.17, and it will be removed in future MySQL versions|
|FLOAT(_p_)|A floating point number. MySQL uses the _p_ value to determine whether to use FLOAT or DOUBLE for the resulting data type. If _p_ is from 0 to 24, the data type becomes FLOAT(). If _p_ is from 25 to 53, the data type becomes DOUBLE()|
|DOUBLE(_size_, _d_)|A normal-size floating point number. The total number of digits is specified in _size_. The number of digits after the decimal point is specified in the _d_ parameter|
|DOUBLE PRECISION(_size_, _d_)||
|DECIMAL(_size_, _d_)|An exact fixed-point number. The total number of digits is specified in _size_. The number of digits after the decimal point is specified in the _d_ parameter. The maximum number for _size_ is 65. The maximum number for _d_ is 30. The default value for _size_ is 10. The default value for _d_ is 0.|
|DEC(_size_, _d_)|Equal to DECIMAL(size,d)|

**Note:** All the numeric data types may have an extra option: UNSIGNED or ZEROFILL. If you add the UNSIGNED option, MySQL disallows negative values for the column. If you add the ZEROFILL option, MySQL automatically also adds the UNSIGNED attribute to the column.

### Date and Time Data Types

|Data type|Description|
|---|---|
|DATE|A date. Format: YYYY-MM-DD. The supported range is from '1000-01-01' to '9999-12-31'|
|DATETIME(_fsp_)|A date and time combination. Format: YYYY-MM-DD hh:mm:ss. The supported range is from '1000-01-01 00:00:00' to '9999-12-31 23:59:59'. Adding DEFAULT and ON UPDATE in the column definition to get automatic initialization and updating to the current date and time|
|TIMESTAMP(_fsp_)|A timestamp. TIMESTAMP values are stored as the number of seconds since the Unix epoch ('1970-01-01 00:00:00' UTC). Format: YYYY-MM-DD hh:mm:ss. The supported range is from '1970-01-01 00:00:01' UTC to '2038-01-09 03:14:07' UTC. Automatic initialization and updating to the current date and time can be specified using DEFAULT CURRENT_TIMESTAMP and ON UPDATE CURRENT_TIMESTAMP in the column definition|
|TIME(_fsp_)|A time. Format: hh:mm:ss. The supported range is from '-838:59:59' to '838:59:59'|
|YEAR|A year in four-digit format. Values allowed in four-digit format: 1901 to 2155, and 0000.  <br>MySQL 8.0 does not support year in two-digit format.|

---

---

## MS SQL Server Data Types

### String Data Types

|Data type|Description|Max char length|Storage|
|---|---|---|---|
|char(n)|Fixed-length non-Unicode character data (n must be between 1 and 8000)|8,000|n bytes (uses one byte for each character)|
|varchar(n)|Variable-length non-Unicode character data (n must be between 1 and 8000)|8,000|n bytes + 2 bytes|
|varchar(max)|Variable-length non-Unicode character data||up to 2 GB|
|nchar(n)|Fixed-length Unicode character data (n must be between 1 and 4000)|4,000|2 * n bytes (uses two bytes for each character)|
|nvarchar(n)|Variable-length Unicode character data (n must be between 1 and 4000)|4,000|2 * n bytes + 2 bytes (uses two bytes for each character)|
|nvarchar(max)|Variable-length Unicode character data||up to 2 GB|
|binary(n)|Fixed-length binary data (n must be between 1 and 8000)|8,000|n bytes|
|varbinary(n)|Variable-length binary data (n must be between 1 and 8000)|8,000|actual length of data entered + 2 bytes|
|varbinary(max)|Variable-length binary data|2GB||

### Numeric Data Types

|Data type|Description|Storage|
|---|---|---|
|bit|Integer that can be 0, 1, or NULL||
|tinyint|Allows whole numbers from 0 to 255|1 byte|
|smallint|Allows whole numbers between -32,768 and 32,767|2 bytes|
|int|Allows whole numbers between -2,147,483,648 and 2,147,483,647|4 bytes|
|bigint|Allows whole numbers between -9,223,372,036,854,775,808 and 9,223,372,036,854,775,807|8 bytes|
|decimal(p,s)|Fixed precision and scale numbers.<br><br>Allows numbers from -10^38 +1 to 10^38 –1.<br><br>The p parameter indicates the maximum total number of digits that can be stored (both to the left and to the right of the decimal point). p must be a value from 1 to 38. Default is 18.<br><br>The s parameter indicates the maximum number of digits stored to the right of the decimal point. s must be a value from 0 to p. Default value is 0|5-17 bytes|
|numeric(p,s)|Fixed precision and scale numbers.<br><br>Allows numbers from -10^38 +1 to 10^38 –1.<br><br>The p parameter indicates the maximum total number of digits that can be stored (both to the left and to the right of the decimal point). p must be a value from 1 to 38. Default is 18.<br><br>The s parameter indicates the maximum number of digits stored to the right of the decimal point. s must be a value from 0 to p. Default value is 0|5-17 bytes|
|smallmoney|Monetary data from -214,748.3648 to 214,748.3647|4 bytes|
|money|Monetary data from -922,337,203,685,477.5808 to 922,337,203,685,477.5807|8 bytes|
|float(n)|Floating precision number data from -1.79E + 308 to 1.79E + 308.<br><br>The n parameter indicates whether the field should hold 4 or 8 bytes. float(24) holds a 4-byte field and float(53) holds an 8-byte field. Default value of n is 53.|4 or 8 bytes|
|real|Floating precision number data from -3.40E + 38 to 3.40E + 38|4 bytes|

### Date and Time Data Types

|Data type|Description|Storage|
|---|---|---|
|datetime|From January 1, 1753 to December 31, 9999 with an accuracy of 3.33 milliseconds|8 bytes|
|datetime2|From January 1, 0001 to December 31, 9999 with an accuracy of 100 nanoseconds|6-8 bytes|
|smalldatetime|From January 1, 1900 to June 6, 2079 with an accuracy of 1 minute|4 bytes|
|date|Store a date only. From January 1, 0001 to December 31, 9999|3 bytes|
|time|Store a time only to an accuracy of 100 nanoseconds|3-5 bytes|
|datetimeoffset|The same as datetime2 with the addition of a time zone offset|8-10 bytes|
|timestamp|Stores a unique number that gets updated every time a row gets created or modified. The timestamp value is based upon an internal clock and does not correspond to real time. Each table may have only one timestamp variable||

### Other Data Types

|Data type|Description|
|---|---|
|sql_variant|Stores up to 8,000 bytes of data of various data types, except text, ntext, and timestamp|
|uniqueidentifier|Stores a globally unique identifier (GUID)|
|xml|Stores XML formatted data. Maximum 2GB|
|cursor|Stores a reference to a cursor used for database operations|
|table|Stores a result-set for later processing|