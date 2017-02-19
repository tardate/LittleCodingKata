using System;

class Timing
{
  public static int Main()
  {
    DateTime start = DateTime.Now;

    // nop
    int i;
    for(i = 1; i<10000; i++)
    {
      double j = i*i/i;
      Console.WriteLine("{0}", j);
    }

    DateTime stop = DateTime.Now;
    TimeSpan theDuration = stop - start;

    Console.WriteLine("Duration = {0}ms", theDuration.Milliseconds);
    return 0;
  }
}
