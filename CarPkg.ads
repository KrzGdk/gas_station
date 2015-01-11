
package CarPkg is
  task type Car is 
    entry start(id : Integer);
    entry stop;
  end;
end CarPkg;