

import UIKit




class CalculatorViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    @IBOutlet weak var resultLable: UILabel!
    @IBOutlet weak var calView: UICollectionView!
    
    var itemArr = Array<String>()
    var items = Array<String>()
    var cur = ""
    var num1 = 0.0
    var num2 = 0.0
    var result = 0.0
    var op = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        for i in 0...9{
            items.append(i.description)
        }
        items.append("+")
        items.append("-")
        items.append("/")
        items.append("*")
        items.append("=")
        items.append("AC")
        
    }
    let reuseIdentifier = "Calcell"
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        cell.calLbl.text = self.items[indexPath.row]
        cell.calLbl.textAlignment = .center
        cell.backgroundColor = UIColor.cyan
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        let ch = items[indexPath.row]
        if(cur == String(result))
        {
            result = 0.0
            cur = ""
        }
        if(ch=="+" || ch=="-" || ch=="*" || ch=="/"  )
        {
            num1 = Double(Float(cur) ?? 0.0)
            op = ch
            
            cur += ch
        }
        else if(ch == "=")
        {
            var flag = false
            var temp = ""
            for x in cur{
                if(flag)
                {
                    temp += String(x)
                }
                else if(x=="+" || x=="-" || x=="*" || x=="/")
                {
                    flag = true
                }
            }
            num2 = Double(Float(temp) ?? 0.0)
            if(op=="+")
            {
                result = num1 + num2
            }
            else if(op=="-")
            {
                result = num1 - num2
            }
            else if(op=="*")
            {
                result = num1 * num2
            }
            else{
                if(num2 != 0)
                {
                    result = num1 / num2
                }
            }
            cur = String(result)
            op = ""
        }
        else if(ch == "AC")
        {
            cur = ""
        }
        else{
            cur += ch
        }
        //        cur += items[indexPath.row]
        resultLable.text = cur
    }
    
    
}
