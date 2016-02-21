# DWSIM Ironpython execnet worker

Facilitates running of DWSIM/DTL Thermodynamic library outside Windows.

```python
import execnet
gw = execnet.makegateway("socket=192.168.1.194:8888")

channel = gw.remote_exec("""
import clr
import sys
sys.path.append("/dwsim/dwsimlib/")
clr.AddReference("DWSIM.Thermodynamics.dll")
import DTL.DTL.SimulationObjects.PropertyPackages
x = DTL.Thermodynamics.Calculator()
x.Initialize()

print channel.receive()
# "First message"
channel.send("Second message")
""")

channel.send("First message")
print channel.receive()
# "Second message"

gw.exit()
```

docker build -t dwsim_execnet .
docker run -p 8888:8888 -dt dwsim_execnet mono /dwsim/IronPython-2.7.5/ipy.exe /dwsim/socketserver2.py
