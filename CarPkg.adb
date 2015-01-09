with Ada.Text_IO;
use Ada.Text_IO;

package body CarPkg is
  task body Car is
  begin
    accept start do
      put_line("carstart");
    end start;
  end Car;

end CarPkg;