

import UIKit

class CityDetailsViewController: UIViewController {
    var cityName: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var conditionLbl: UILabel!
    @IBOutlet weak var conditionImg: UIImageView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    var weather: Weather!
    
    func loadImge(str: String){
        
        let temp = "https:"+str
        //        print(temp)
        if let imageURL = URL(string: temp) {
            if let imageData = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: imageData) {
                    
                    conditionImg.image = image
                }
            }
        }
    }
    func digit(x: Character)->Int{
        if(x=="0")
        {
            return 0;
        }
        if(x=="1")
        {
            return 1
        }
        if(x=="2")
        {
            return 2
        }
        if(x=="3")
        {
            return 3
        }
        if(x=="4")
        {
            return 4
        }
        if(x=="5")
        {
            return 5
        }
        if(x=="6")
        {
            return 6
        }
        if(x=="7")
        {
            return 7
        }
        if(x=="8")
        {
            return 8
        }
        return 9
    }

    func  getWeather(latitude: Double, longitude: Double){
        
        let indicatorView = activityIndicator(style: .large,
                                                   center: self.view.center)
        
        self.view.addSubview(indicatorView)
        
        
        indicatorView.startAnimating()
        
        let temp = String (latitude) + "," + String (longitude)
        //        print(temp)
        let str = "https://api.weatherapi.com/v1/current.json?key=1f1c2b7ed5d74ad3ae160133231910&q="+temp+"&aqi=no"
        //        print(str)
        let url = URL(string: str)
        //        print(url!)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do{
                
                if(error == nil)
                {
                    self.weather = try JSONDecoder().decode(Weather.self, from: data!)
                    //                    print("The temp is:",self.weather.current.temp_c)
                    
                    let temp = self.weather.location.localtime
                    var time = ""
                    var date = ""
                    var flag = false
                    for x in temp{
                        if(x==" ")
                        {
                            flag = true
                        }
                        if(flag)
                        {
                            time.append(x)
                        }
                        else if(!flag)
                        {
                            date.append(x)
                        }
                    }
                    
                    var hh = 0
                    var mm = 0
                    flag = false
                    for x in time{
                        if(x == ":")
                        {
                            flag = true
                            continue
                        }
                        if(x>="0"&&x<="9")
                        {
                            if(!flag)
                            {
                                
                                hh = hh*10 + self.digit(x:x)
                            }
                            else
                            {
                                mm = mm*10 + self.digit(x: x)
                            }
                        }
                    }
                    print(hh,":",mm)
                    if(hh <  12)
                    {
                        time.append(" AM")
                    }
                    else if(hh == 12)
                    {
                        time.append(" PM")
                    }
                    else
                    {
                        
                        hh = hh % 12
                        time = ""
                        if(hh<10)
                        {
                            //                            time = "0"
                        }
                        time.append(String(hh))
                        time.append(":")
                        if(mm<10)
                        {
                            time.append("0")
                        }
                        time.append(String(mm))
                        
                        time.append(" PM")
                        
                    }
                    
                    DispatchQueue.main.async {
                        indicatorView.stopAnimating()
                        self.cityNameLbl.isHidden = false
                        self.tempLbl.isHidden = false
                        self.conditionLbl.isHidden = false
                        self.conditionImg.isHidden = false
                        self.timeLbl.isHidden = false
                        self.dateLbl.isHidden = false
                        
                        let st = String (self.weather.current.temp_c)
                        self.tempLbl.text = st + " \u{00B0}C"
                        self.conditionLbl.text = String (self.weather.current.condition.text)
                        self.loadImge(str: self.weather.current.condition.icon)
                        self.timeLbl.text = time
                        self.dateLbl.text = date
                        if(self.weather.current.is_day == 0){
                            self.view.backgroundColor = UIColor(hexString: "212124")
                            self.tempLbl.textColor = .white
                            self.conditionLbl.textColor = .white
                            self.cityNameLbl.textColor = .white
                            self.timeLbl.textColor = .white
                            self.dateLbl.textColor = .white
                        }
                        
                    }
                    
                }
                
            }
            catch{
                DispatchQueue.main.async {
                    indicatorView.stopAnimating()
                    self.showToast(message: "Something Went Wrong", font: .systemFont(ofSize: 18.0))
                }
                print("Error in json data \(error)")
            }
            
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityNameLbl.isHidden = true
        tempLbl.isHidden = true
        conditionLbl.isHidden = true
        conditionImg.isHidden = true
        timeLbl.isHidden = true
        dateLbl.isHidden = true
        
        cityNameLbl.text = cityName
        getWeather(latitude: latitude, longitude: longitude)
        
    }
    
    
    
}
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
