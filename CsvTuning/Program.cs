using System;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using Microsoft.EntityFrameworkCore;
using Npgsql;

namespace CsvTuning
{
  public class MyContext : DbContext
  {
    public static readonly string CONNECTION_STRING = "Host=localhost;port=15432;Database=postgres;Username=postgres;Password=pgpw";
    public DbSet<Staff> staff { get; set; }
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseNpgsql(CONNECTION_STRING);
  }
  public class Staff
  {
    public int id { get; set; }
    public string last_name { get; set; }
    public string department { get; set; }
  }

  class Program
  {
    static void Main(string[] args)
    {
      var csvRecords = new StringBuilder();
      for (int i = 0; i < 10000; i++)
      {
        if (i > 0) csvRecords.Append("\n");
        csvRecords.Append($"{i},breno{i},Movies");
      }
      var dbContex = new MyContext();
      Stopwatch stopWatch = new Stopwatch();
      stopWatch.Start();
      var allStaffsFromSQL = dbContex.staff.FromSqlInterpolated
      (
        $@"SELECT 
        s.f[1]::int AS id,
        s.f[2] AS last_name,
        s.f[3] AS department  
        FROM 
        (
         SELECT regexp_split_to_array(l, ',') AS f 
         FROM regexp_split_to_table({csvRecords.ToString()}, '\n') AS l
        ) as s
        LEFT JOIN company_divisions as cd ON ( cd.department = s.f[3] );
        "
      ).ToArray();
      stopWatch.Stop();
      TimeSpan ts = stopWatch.Elapsed;
      // Format and display the TimeSpan value.
      string elapsedTime = String.Format("{0:00}:{1:00}:{2:00}.{3:00}",
          ts.Hours, ts.Minutes, ts.Seconds,
          ts.Milliseconds / 10);
      Console.WriteLine("RunTime " + elapsedTime);
      Console.WriteLine(allStaffsFromSQL.Length);
      NpgsqlConnection conn = new NpgsqlConnection(MyContext.CONNECTION_STRING);
      conn.Open();
      stopWatch.Reset();
      stopWatch.Start();
      NpgsqlCommand command = new NpgsqlCommand(
        $@"SELECT 
        s.f[1]::int AS id,
        s.f[2] AS last_name,
        s.f[3] AS department  
        FROM 
        (
         SELECT regexp_split_to_array(l, ',') AS f 
         FROM regexp_split_to_table($${csvRecords.ToString()}$$, '\n') AS l
        ) as s
        LEFT JOIN company_divisions as cd ON ( cd.department = s.f[3] );
        ", conn);

      // Execute the query and obtain a result set
      NpgsqlDataReader dr = command.ExecuteReader();

      // Output rows treen rows
      var countRows = 0;
      while (dr.Read())
      {
        Console.Write("{0}\t{1} \n", dr[0], dr[1]);
        countRows++;
        //if (countRows > 3) break;
      }
      dr.Close();
      stopWatch.Stop();
      ts = stopWatch.Elapsed;
      elapsedTime = String.Format("{0:00}:{1:00}:{2:00}.{3:00}",
          ts.Hours, ts.Minutes, ts.Seconds,
          ts.Milliseconds / 10);
      Console.WriteLine("RunTime " + elapsedTime);
      Console.WriteLine(allStaffsFromSQL.Length);
      conn.Close();

    }
  }
}
