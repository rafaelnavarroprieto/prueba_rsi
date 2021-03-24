class AgentTransactor

  def self.process(sender_id, receiver_id, amount_transfer)
    while Transaction.total_amount_by_account(sender_id) < amount_transfer
      Transaction.create!(account_sender_id: sender_id, account_received_id: receiver_id, amount: 1000)
      puts "Transaction success. jim account amount: #{Account.find(sender_id).amount}"
    end

    puts "Accounts"
    Account.all.each do |account|
      puts "bank: #{account.bank.name}"
      puts "-------------------"
      puts "owner: #{account.owner}"
      puts "isbn: #{account.isbn}"
      puts "money: #{account.amount}"
      puts "-------------------"
    end

    while Transaction.failure_transactions(sender_id).count != 0
      puts "currently #{Transaction.failure_transactions(sender_id).count} transactions failed"
      Transaction.failure_transactions(sender_id).each do |transaction|
        transaction.do_transaction
        if transaction.finished
          puts "Transaction success."
        else
          puts "Transaction failed."
        end
      end
    end

    puts "Accounts"
    Account.all.each do |account|
      puts "bank: #{account.bank.name}"
      puts "-------------------"
      puts "owner: #{account.owner}"
      puts "isbn: #{account.isbn}"
      puts "money: #{account.amount}"
      puts "-------------------"
    end
  end  
end