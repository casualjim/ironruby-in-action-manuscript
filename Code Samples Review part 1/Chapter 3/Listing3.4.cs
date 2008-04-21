public class StringAdder
{
    private readonly List<string> _stringList;

    public delegate void OnStringAddedDelegate(string addedValue);	1
    public event OnStringAddedDelegate OnStringAdded;	2



    public StringAdder()
    {
        _stringList = new List<string>();
    }


    public void Add(string value)
    {
        _stringList.Add(value);
        OnStringAdded(value);	3
    }


    public override string ToString()
    {
        return string.Join(", ", _stringList.ToArray());
    }
}