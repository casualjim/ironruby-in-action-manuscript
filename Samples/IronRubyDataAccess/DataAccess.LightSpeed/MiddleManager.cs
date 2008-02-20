using Mindscape.LightSpeed;

namespace DataAccess.LightSpeed
{
  [Discriminator(Attribute="ReportsToId", Value=2)]
  public sealed class MiddleManager : Employee
  {
  }
}