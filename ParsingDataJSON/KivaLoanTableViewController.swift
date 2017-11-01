//
//  KivaLoanTableViewController.swift
//  ParsingDataJSON
//
//  Created by Sam Pramudana on 11/1/17.
//  Copyright © 2017 Sam Pramudana. All rights reserved.
//

import UIKit

class KivaLoanTableViewController: UITableViewController {
    
    //deklarasi url untuk mengambil data json
    let kivaLoanURL = "https://api.kivaws.org/v1/loans/newest.json"
    //deklarasi variable loans untuk memanggil class loan yang sudah dibuat sebelumnya
    var loans = [Loan]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //mengambil data dari API Loans
        getLatestLoans()
        
        //self sizing cells
        //mengatur tinggi row table menjadi 92
        tableView.estimatedRowHeight = 92.0
        //mengatur tinggi row Table menjadi dimensi otomatis
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return loans.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! KivaLoanTableViewCell

        // Configure the cell...
        //memasukkan nilainNya kedalam masing2 label
        cell.nameLabel.text = loans[indexPath.row].name
        cell.countryLabel.text = loans[indexPath.row].country
        cell.useLabel.text = loans[indexPath.row].use
        cell.amountLabel.text = "$\(loans[indexPath.row].amount)"

        return cell
    }
    // MARK: - JSON Parsing
    //membuat method baru dengan nama : getLatestLoans()
    func getLatestLoans() {
        //deklarasi loanUrl untuk memanggil variable kivaLoanURL yang telah dideklarasi sebelumnya
        guard let loanUrl = URL(string: kivaLoanURL) else {
            return //return ini berfungsi untuk mengembalikan nilai yang sudah didapat ketik memanggil variable loanUrl
        }
        
        //deklarasi request untuk request URL loanUrl
        let request = URLRequest(url: loanUrl)
        //deklarasi task untuk mengambil data dari variable request diatas
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            //mengecek apakah ada error apa tidak
            if let error = error {
                //kondisi ketika ada error
                //mencetak error
                print(error)
                return //mengembalikkan nilai error yang didapat
            }
            
            // parse JSON data
            //deklarasi variable data untuk memanggil data
            if let data = data {
                //pada bagian ini kita akan memanggil method parseJsonData yang akan kita buat dibawah
                self.loans = self.parseJsonData(data: data)
                
                //reload tableView
                OperationQueue.main.addOperation ({
                    //reloadData kembali
                    self.tableView.reloadData()
                })
            }
        })
        //task akan melakukan resume untuk memanggil data json nya
        task.resume()
    }
    //membuat method baru dengan nama parseJsonData
    //method ini akan melakukkan parsing data json
    func parseJsonData(data: Data) -> [Loan] {
        //deklarasi variable loans sebagai objek dari class Loan
        var loans = [Loan]()
        //akan melakukkan perulangan terhadap data json yang d parsing
        do {
            //deklarasi jsonResult untuk mengambil data dari jsonnya
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            //parse JSON data
            //deklarasi jsonLoans untuk memanggil data array jsonResult yang bernama Loans
            let jsonLoans = jsonResult?["loans"] as! [AnyObject]
            //akan melakuan pemanggilan data berulang2 selama jsonLoan memiliki data json array dari variable jsonLoans
            for jsonLoan in jsonLoans {
                //deklarasi loan sebagai objek dari class Loan
                let loan = Loan()
                //memasukkan nilai kedalam masing2 objek dari class Loan
                //memasukkan nilai jsonLoan dengan nama object sebagai String
                loan.name = jsonLoan["name"] as! String
                //memasukkan nilai jsonLoan dengan nama objek loan_amount sebagai integer
                loan.amount = jsonLoan["loan_amount"] as! Int
                //memasukkan nilai jsonLoan dengan nama object use sebagai String
                loan.use = jsonLoan["use"] as! String
                //memasukkan nilai jsonLoan dengan nama object location sebagai String
                let location = jsonLoan["location"] as! [String:AnyObject]
                //memasukkan nilai jsonLoan dengan nama object country sebagai String
                loan.country = location["country"] as! String
                //proses memasukkan data kedalam object
                loans.append(loan)
            }
        }catch{
            print(error)
        }
        return loans
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
