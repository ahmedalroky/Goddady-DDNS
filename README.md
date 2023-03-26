# Godaddy DDNS  
This is a simple Bash script to update a Godaddy domain's DNS record with the current public IP address of the host it is executed on.  

## Prerequisites:  
Access to a Godaddy account with a domain  
- Bash shell  
- curl  
- A Linux system with cron to schedule the script execution  
  
## Installation:  
- Clone the repository:  
```bash 
git clone https://github.com/ahmedalroky/Goddady-DDNS.git  
```
- Replace "YOUR_DOMAIN" and "api:secret" in the script with your own Godaddy domain name and API key respectively.  
  
- Make the script executable:  
  
```bash  
chmod +x godaddy-ddns.sh  
```
- Test the script by running it:  
```bash  
./godaddy-ddns.sh  
```
## Usage:  
You can schedule the script to run automatically by setting up a cron job.  

For example, to run the script every 30 minutes, add the following line to your crontab file:  

```bash 
*/30 * * * * /path/to/godaddy-ddns.sh  
```
This will run the script every 30 minutes and update the DNS record if the public IP address has changed.  
  
## Logging:  
The script logs the date, time and IP address to a log file located at "/var/log/godaddy.log". You can view the log file to see the update history.  
  
## License:  
This project is licensed under the MIT License - see the LICENSE file for details.  
