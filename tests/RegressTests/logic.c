   int main()
{
   int a=1, b=0, c;
   
   c = a&b;
   print ("c  0");
   printid(c);

   c = a|a;
   print ("c  1");
   printid(c);

   c = a|b;
   print ("c  1");
   printid(c);

   c = a^a;
   print ("c  0");
   printid(c);

   c = (a^a) || (a|b);
   print ("c  1");
   printid(c);

   c = (a^a) && (a|b);
   print ("c  0");
   printid(c);

   return 0;
}