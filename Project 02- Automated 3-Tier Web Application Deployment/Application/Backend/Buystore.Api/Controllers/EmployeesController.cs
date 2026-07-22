using Buystore.Api.Models;
using Microsoft.AspNetCore.Mvc;

namespace Buystore.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class EmployeesController : ControllerBase
{
    private static readonly List<Employee> Employees =
    [
        new Employee
        {
            Id = 1,
            FirstName = "Benjamin",
            LastName = "Okeh",
            Email = "benjamin.okeh@buystore.com",
            Department = "Information Technology",
            JobTitle = "IT Manager",
            DateCreatedUtc = DateTime.UtcNow
        },
        new Employee
        {
            Id = 2,
            FirstName = "Sarah",
            LastName = "Bankole",
            Email = "sarah.bankole@buystore.com",
            Department = "Human Resources",
            JobTitle = "HR Manager",
            DateCreatedUtc = DateTime.UtcNow
        }
    ];

    [HttpGet]
    public ActionResult<IEnumerable<Employee>> GetEmployees()
    {
        return Ok(Employees);
    }

    [HttpGet("{id:int}")]
    public ActionResult<Employee> GetEmployeeById(int id)
    {
        var employee = Employees.FirstOrDefault(e => e.Id == id);

        if (employee is null)
        {
            return NotFound(new
            {
                message = $"Employee with ID {id} was not found."
            });
        }

        return Ok(employee);
    }
}