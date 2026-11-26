PROTOCOL_ID_DEFINES = {
	EchoReq_ID = 10001,
	EchoAck_ID = 10002
}
EchoAck = {
	EchoAckLen,
	EchoAckContent
}
EchoReq = {
	EchoReqLen,
	EchoReqContent
}
PacketHeader = {
	MsgID,
	Length,
	Sequence
}
