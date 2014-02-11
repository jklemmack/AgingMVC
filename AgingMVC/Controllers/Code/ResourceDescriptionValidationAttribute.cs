using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace AgingMVC.Controllers.Code
{
    public class ResourceDescriptionValidationAttribute : ValidationAttribute
    {
        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            bool success = true;
            string v = value as string;

            if (success && v == null)
                success = false;

            Regex re = new Regex(@"^[^\[\]]* (?<url>\[ [^\[]+ \]) [^\[\]]*$", RegexOptions.IgnoreCase | RegexOptions.Singleline | RegexOptions.IgnorePatternWhitespace);

            success = !re.IsMatch(v);
            if (!success)
                return new ValidationResult("Value must contain a string with a single pair of matching square brackets [].");

            return null;
            //return base.IsValid(value, validationContext);
        }
    }
}