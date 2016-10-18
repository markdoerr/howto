
ssh howto
=========


Public key authentification
___________________________

(s. ssh documentation)

  just generate a private/public key pair by

  ssh-keygen  
  # private and public kies are  by default in .ssh/: private: id_rsa, public key : id_rsa.pub)
  # add the public key to the authorized_keys file on remote host in ~/.ssh (one key per line)
  
  mv .ssh/id_rsa.pub .ssh/authorized_keys 
  
  # test the ssh connection (if its working it should ask you for a key authentification), and you you can type 
  
  ssh user@myserver # without adding a pwd
  
  
Public key authentication works as follows: The scheme is based on public-key cryptography, using cryptosystems where encryption and decryption are done using separate keys, and it is unfeasible to derive the decryption key from the encryption key.  The idea is that each user creates a public/private key pair for authentication purposes.  The server knows the public key, and only the user knows the private key.  ssh implements public key authentication protocol automatically, using one of the DSA, ECDSA, ED25519 or RSA algorithms.  Protocol 1 is restricted to using only RSA keys, but protocol 2 may use any.  The HISTORY section of ssl(8) (on non-OpenBSD systems, see http://www.openbsd.org/cgi-bin/man.cgi?query=ssl&sektion=8#HISTORY) contains a brief discussion of the DSA and RSA algorithms.

The file ~/.ssh/authorized_keys lists the public keys that are permitted for logging in.  When the user logs in, the ssh program tells the server which key pair it would like to use for authentication.  The client proves that it has access to the private key and the server checks that the corresponding public key is authorized to accept the account.

The user creates his/her key pair by running 
ssh-keygen(1).  This stores the private key in ~/.ssh/identity (protocol 1), ~/.ssh/id_dsa (protocol 2 DSA), ~/.ssh/id_ecdsa (protocol 2 ECDSA), ~/.ssh/id_ed25519 (protocol 2 ED25519), or ~/.ssh/id_rsa (protocol 2 RSA)

and 

stores the public key in ~/.ssh/identity.pub (protocol 1), ~/.ssh/id_dsa.pub (protocol 2 DSA), ~/.ssh/id_ecdsa.pub (protocol 2 ECDSA), ~/.ssh/id_ed25519.pub (protocol 2 ED25519), or ~/.ssh/id_rsa.pub (protocol 2 RSA) in the user's home directory. 

The user should then copy the public key to ~/.ssh/authorized_keys in his/her home directory on the remote machine.  The authorized_keys file corresponds to the conventional ~/.rhosts file, and has one key per line, though the lines can be very long.  After this, the user can log in without giving the password.



A variation on public key authentication is available in the form of certificate authentication: instead of a set of public/private keys, signed certificates
are used.  This has the advantage that a single trusted certification authority can be used in place of many public/private keys.  See the CERTIFICATES section
of ssh-keygen(1) for more information.

The most convenient way to use public key or certificate authentication may be with an authentication agent.  See ssh-agent(1) for more information.
