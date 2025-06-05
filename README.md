# RSA-algorithm
This is a code which implements the RSA algorithm for cryptography and let's you see it working.

This implementation is almost complete, I had to use smaller numbers for the sake of computational time, but it's very close to the official way to implement a safe RSA.

You may use this code as a guide when you are learning or when you try to implement your own version.

Notice it uses the number 85 as the plain text message before it creates the cypher text message, you can change this number if you wish, it will first encrypt and then decrypt the number.

If you want to run it then just compile it with the DMD compiler by typing "dmd source.d -m64 -i -J. -O -g" and then run it, it tells the user all the variables and how long it will take to finish decrypting the cypher text message.
