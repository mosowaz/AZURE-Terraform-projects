## Application gateway with path-based routing rules

### Demo Link: https://learn.microsoft.com/en-us/azure/application-gateway/create-url-route-portal

<p align="center">
  <img src="https://learn.microsoft.com/en-us/azure/application-gateway/media/application-gateway-create-url-route-portal/scenario.png" alt="IApplication Gateway" width="700">
</p>

URL paths are "/images/*" and "/videos/*"

Azure Application Gateway is a load balancer that enables you to manage and optimize the traffic to your web applications. \
Since upgrade mode for the backend VMSS is set to "Manual", a manual upgrade is required after provisioning of the VMSS. \
Go to the VMSS resource --> Click "Instances" --> Select the VM instances you want to upgrade --> Click "Upgrade". 

![alt text](scripts/image.png)

Now test the Application gateway frontend IP to validate the you can reach the backend.

## Expected Results
