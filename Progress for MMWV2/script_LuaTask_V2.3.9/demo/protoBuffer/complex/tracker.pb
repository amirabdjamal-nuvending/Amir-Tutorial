
?
tracker.prototracker"_
GPS
	longitude (
latitude (
degree (
speed (
viewed_sates ("?

LacAndCell(
cells (2.tracker.LacAndCell.Cells

ta (?
Cells
lac_id (-
cells (2.tracker.LacAndCell.Cells.CellD
Cell
mcc (
mnc (
cell_id (
	cell_rssi ("?
Status
shake (
charger (
acc (
gps (
rssi (
vbat (3
charge_status (2.tracker.Status.ChargeStatus"A
ChargeStatus

NOT_CHARGE 
CHARGING
CHARGE_COMPLETE"~
LogIn

project_id (
project_name (	
script_version (	
iccid (	
imsi (	
heart_interval ("?
Location,
type (2.tracker.Location.LocationType
	gps_exist (
gps_info (2.tracker.GPS

cell_exist (&
	cell_info (2.tracker.LacAndCell
status (2.tracker.Status"_
LocationType
DEV_TIMER_REPORT 
SVR_QUERY_RSP
DEV_SOS_REPORT
DEV_KEY_REPORT"(
Heart
status (2.tracker.Status"Z
DevParaReport
type (2.tracker.ParaType
guard (
location_interval ("C
DevSvrSetParaRsp
type (2.tracker.ParaType
result ("G
DevSvrEventRsp%
type (2.tracker.SvrMessageType
result ("?
Client3

message_id (2.tracker.Client.ClientMessageID
log_in (2.tracker.LogIn#
location (2.tracker.Location
heart (2.tracker.Heart+
para_report (2.tracker.DevParaReport/
set_para_rsp (2.tracker.DevSvrSetParaRsp*
	event_rsp (2.tracker.DevSvrEventRsp"?
ClientMessageID
	DEV_LOGIN 
DEV_LOCATION
	DEV_HEART
DEV_PARA_REPORT
DEV_SVRSETPARA_RSP
DEV_SVREVENT_RSP"W

SvrSetPara
type (2.tracker.ParaType
guard (
location_interval ("`
Server+

message_id (2.tracker.SvrMessageType)
svr_set_para (2.tracker.SvrSetPara*,
ParaType	
GUARD 
LOCATION_INTERVAL*l
SvrMessageType
SVR_SET_PARA 
SVR_QUERY_LOCATION
	SVR_RESET
SVR_POWEROFF
SVR_RESTORE