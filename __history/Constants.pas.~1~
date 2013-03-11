unit Constants;

interface

uses Classes;

type
  TAliasParams = array[1..12] of string;

const
  SQL_CREATE_FUR: string = 'CREATE TABLE IF NOT EXISTS `fur` (' +
    '`COD_FISCAL` char(15) NOT NULL,' +
    '`CODFUR` char(15) NOT NULL,' +
    '`NRORDREG` char(14) NOT NULL,' +
    '`DENFUR` char(30) NOT NULL,' +
    '`ADRF` char(25) NOT NULL,' +
    '`LOCALITATE` char(25) NOT NULL,' +
    '`CODPOSTAL` char(6) NOT NULL,' +
    '`JUDET` char(25) NOT NULL,' +
    '`TELEFON` char(12) NOT NULL,' +
    '`FAX` char(12) NOT NULL,' +
    '`TELEX` char(12) NOT NULL,' +
    '`CONT_EUR` char(20) NOT NULL,' +
    '`CONT_RON` char(20) NOT NULL,' +
    '`NR_CONTR` char(25) NOT NULL,' +
    '`EMAIL` char(50) NOT NULL,' +
    'PRIMARY KEY  (`CODFUR`),' +
    'KEY `DENUMIRE` (`DENFUR`)' +
    ') ENGINE=MyISAM DEFAULT CHARSET=latin1;';
  ALIAS_PARAMS: TAliasParams = ('DATABASE', 'dbCabConta', 'DESCRIPTION', 'dsCabConta', 'PORT', '3306', 'SERVER', 'localhost', 'UID', 'root', 'PID', '');
  FORM_COLOR: integer = $00F4D3B9;
  ALIASNAME: String = 'CabConta';

  C2_PL1: string = 'STL';
  C2_PL2: string = 'ScAv';
  C2_PL3: string = 'DANU';
  LOGGING: boolean = True;
  LOG_FILE: string = '\Date\err.log';

  CL_ADAUGA     = 1 shl 1;
  CL_MODIFICA   = 1 shl 2;
  CL_INIT       = 1 shl 3;

  VERSION = '1.1.2.2';
  DATA_ACT = '15.09.2009';


{  TAG DEFINITIONS
  TEdit           =   2;
  TLabeledEdit    =   4;
  TComboBox       =   8;
  TLabel          =  16
}

implementation

end.
