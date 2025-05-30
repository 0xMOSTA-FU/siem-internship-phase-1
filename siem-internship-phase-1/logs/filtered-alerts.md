from Management -> Dev Tools :

## Brute Force
--------
Shell:
```shell
GET winlogbeat-*/_search
{
  "size": 100,
  "_source": ["@timestamp", "event.code", "source.ip", "user.name", "host.name", "message"],
  "query": {
    "bool": {
      "must": [
        { "match": { "event.code": "4625" }},
        { "match": { "user.name": "mosta" }},
        { "range": { "@timestamp": { "gte": "now-2d/d", "lt": "now/d" }}}
      ]
      
    }
  }
}

```

Result:
```json
{
  "took": 52,
  "timed_out": false,
  "_shards": {
    "total": 1,
    "successful": 1,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 1,
      "relation": "eq"
    },
    "max_score": 8.780318,
    "hits": [
      {
        "_index": ".ds-winlogbeat-9.0.1-2025.05.15-000001",
        "_id": "M1cYJZcB2vHXhP1vtdtL",
        "_score": 8.780318,
        "_source": {
          "source": {
            "ip": "127.0.0.1"
          },
          "message": """An account failed to log on.

Subject:
	Security ID:		S-1-5-18
	Account Name:		DESKTOP-RM6P0RP$
	Account Domain:		WORKGROUP
	Logon ID:		0x3e7

Logon Type:			2

Account For Which Logon Failed:
	Security ID:		S-1-0-0
	Account Name:		mosta
	Account Domain:		DESKTOP-RM6P0RP

Failure Information:
	Failure Reason:		Unknown user name or bad password.
	Status:			0xc000006d
	Sub Status:		0xc000006a

Process Information:
	Caller Process ID:	0x21c
	Caller Process Name:	C:\Windows\System32\svchost.exe

Network Information:
	Workstation Name:	DESKTOP-RM6P0RP
	Source Network Address:	127.0.0.1
	Source Port:		0

Detailed Authentication Information:
	Logon Process:		User32 
	Authentication Package:	Negotiate
	Transited Services:	-
	Package Name (NTLM only):	-
	Key Length:		0

This event is generated when a logon request fails. It is generated on the computer where access was attempted.

The Subject fields indicate the account on the local system which requested the logon. This is most commonly a service such as the Server service, or a local process such as Winlogon.exe or Services.exe.

The Logon Type field indicates the kind of logon that was requested. The most common types are 2 (interactive) and 3 (network).

The Process Information fields indicate which account and process on the system requested the logon.

The Network Information fields indicate where a remote logon request originated. Workstation name is not always available and may be left blank in some cases.

The authentication information fields provide detailed information about this specific logon request.
	- Transited services indicate which intermediate services have participated in this logon request.
	- Package name indicates which sub-protocol was used among the NTLM protocols.
	- Key length indicates the length of the generated session key. This will be 0 if no session key was requested.""",
          "@timestamp": "2025-05-29T13:26:28.056Z",
          "host": {
            "name": "desktop-rm6p0rp"
          },
          "event": {
            "code": "4625"
          },
          "user": {
            "name": "mosta"
          }
        }
      }
    ]
  }
}
```
![Screenshot 2025-05-31 141044](https://github.com/user-attachments/assets/73b915e4-19db-4007-a685-0534c78f5ac0)

![image](https://github.com/user-attachments/assets/72a32bfd-ee14-48af-90d3-7150e9910ee7)

------------------
