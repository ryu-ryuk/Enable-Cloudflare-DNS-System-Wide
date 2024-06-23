#!/system/bin/sh

# Cloudflare DNS addresses
CLOUDFLARE_DNS1="1.1.1.1"
CLOUDFLARE_DNS2="1.0.0.1"

# Apply DNS settings for net.dns1
resetprop net.dns1 $CLOUDFLARE_DNS1

# Apply DNS settings for net.dns2
resetprop net.dns2 $CLOUDFLARE_DNS2

# Apply additional DNS settings for net.rmnet0 and net.rmnet1 if needed
resetprop net.rmnet0.dns1 $CLOUDFLARE_DNS1
resetprop net.rmnet0.dns2 $CLOUDFLARE_DNS2
resetprop net.rmnet1.dns1 $CLOUDFLARE_DNS1
resetprop net.rmnet1.dns2 $CLOUDFLARE_DNS2

# Apply iptables rules to enforce DNS
iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 1.1.1.1:53
iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 1.1.1.1:53
