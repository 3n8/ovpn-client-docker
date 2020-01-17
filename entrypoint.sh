set -x

#iptables --flush
#iptables --delete-chain

#iptables -t nat --flush
#iptables -t nat --delete-chain
#iptables -P OUTPUT DROP
#iptables -A INPUT -j ACCEPT -i lo
#iptables -A OUTPUT -j ACCEPT -o lo
#iptables -A INPUT --src $LOCAL_NETWORK -j ACCEPT -i eth0
#iptables -A OUTPUT -d $LOCAL_NETWORK -j ACCEPT -o eth0
#iptables -A OUTPUT -j ACCEPT -d $VPN_IP -o eth0 -p udp -m udp --dport $VPN_PORT
#iptables -A INPUT -j ACCEPT -s $VPN_IP -i eth0 -p udp -m udp --sport $VPN_PORT
#iptables -A OUTPUT -j ACCEPT -d 1.1.1.1 -o eth0 -p udp -m udp --dport 53
#iptables -A INPUT -j ACCEPT -s 1.1.1.1 -i eth0 -p udp -m udp --sport 53
#iptables -A OUTPUT -j ACCEPT -d 8.8.8.8 -o eth0 -p udp -m udp --dport 53
#iptables -A INPUT -j ACCEPT -s 8.8.8.8 -i eth0 -p udp -m udp --sport 53
#iptables -A OUTPUT -j ACCEPT -d 1.1.1.1 -o eth0 -p tcp -m tcp --dport 53
#iptables -A INPUT -j ACCEPT -s 1.1.1.1 -i eth0 -p tcp -m tcp --sport 53
#iptables -A OUTPUT -j ACCEPT -d 8.8.8.8 -o eth0 -p tcp -m tcp --dport 53
#iptables -A INPUT -j ACCEPT -s 8.8.8.8 -i eth0 -p tcp -m tcp --sport 53
#iptables -A INPUT -j ACCEPT -i tun0
#iptables -A OUTPUT -j ACCEPT -o tun0

#ufw --force reset
#ufw default deny incoming
#ufw default deny outgoing 
#ufw allow in on tun0
#ufw allow out on tun0
#ufw allow in on eth0 from $LOCAL_NETWORK
#ufw allow out on eth0 to $LOCAL_NETWORK
#ufw allow out on eth0 to $VPN_IP port $VPN_PORT proto $VPN_PROTO
#ufw allow in on eth0 from $VPN_IP port $VPN_PORT proto $VPN_PROTO
#ufw enable

# https://security.stackexchange.com/questions/183177/openvpn-kill-switch-on-linux

## Flush the tables. This may cut the system's internet.
#iptables -F
#
## Let the VPN client communicate with the outside world.
#iptables -A OUTPUT -j ACCEPT -m owner --gid-owner 101
#
## The loopback device is harmless, and TUN is required for the VPN.
#iptables -A OUTPUT -j ACCEPT -o lo
#iptables -A OUTPUT -j ACCEPT -o tun+
#
## We should permit replies to traffic we've sent out.
#iptables -A INPUT -j ACCEPT -m state --state ESTABLISHED
#
## The default policy, if no other rules match, is to refuse traffic.
#iptables -P OUTPUT DROP
#iptables -P INPUT DROP

#addgroup -g 1000 killswitch

#iptables -A OUTPUT -m owner --gid-owner killswitch -j ACCEPT 
#iptables -A OUTPUT -o tun0 -j ACCEPT
#iptables -A OUTPUT -o lo -j ACCEPT 
#iptables -A OUTPUT -j REJECT --reject-with icmp-admin-prohibited

openvpn --config $CONFIG --group killswitch