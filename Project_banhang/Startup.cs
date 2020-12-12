using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Project_banhang.Startup))]
namespace Project_banhang
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
