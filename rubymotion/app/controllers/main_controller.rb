#class MainController < UIViewController
#  def viewDidLoad
#    super
#
#    self.view.backgroundColor = UIColor.whiteColor
#
#    @label = UILabel.alloc.initWithFrame(CGRectZero)
#    @label.text = "Taps"
#    @label.sizeToFit
#    @label.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)
#    self.view.addSubview @label
#
#
#
#    alert = UIAlertView.alloc.init
#    alert.message = "#{@data[indexPath.row]} tapped!"
#    alert.addButtonWithTitle "OK"
#    alert.show
#  end
#end


# You have to inherit from UIViewController
class MainController < UIViewController

  # Called after the view is loaded
  def viewDidLoad
    self.view.backgroundColor = UIColor.whiteColor

    # A text input field instantiated with initWithFrame
    @input_field = UITextField.alloc.initWithFrame([[60, 100], [200, 40]])

    # Set the text color using the UIColor class which offers named colors
    @input_field.textColor = UIColor.blackColor

    # Set the background color for the text field
    @input_field.backgroundColor = UIColor.whiteColor

    # Set the border style of the text field to rounded rectangle
    # We need a rounded border, defined by the constant UITextBorderStyleRoundedRect
    @input_field.setBorderStyle UITextBorderStyleRoundedRect
    @input_field.delegate = self

    # Add the text field to the controller's view
    self.view.addSubview @input_field


    # Initiate button with button type
    @action_button = UIButton.buttonWithType UIButtonTypeRoundedRect

    # Set the title for the default UI state, which is normal
    # Normal UI state is defined by the constant UIControlStateNormal
    @action_button.setTitle "Save", forState: UIControlStateNormal

    # Set the frame for the button
    @action_button.frame = [[100, 150], [100, 50]]

    # Add an event for the button when touched
    # 'self' refers to the handler class for the action in which the callback is defined
    # greet_user is the method is that'll be called when the event happens
    # The touch state is defined by the constant UIControlEventTouchUpInside
    @action_button.addTarget(self,
      action: :greet_user,
      forControlEvents: UIControlEventTouchUpInside)

    # Add the button to the view
    self.view.addSubview @action_button
  end

  # The touch callback for the button
  def greet_user
    App::Persistence[:name] = @input_field.text

    # Instantiate an alert box with the title and a greeting message
    # And a text for the cancel button
    # Which will say "ok"
    # The arguments from the second to last, are not Ruby hash arguments
    # They are Objective-C style arguments.
    # You can't randomize the order or skip them if they are nil
    @alert_box = UIAlertView.alloc.initWithTitle("Greeting",
        message:"Hi #{App::Persistence[:name]}",
        delegate: nil,
        cancelButtonTitle: "ok",
        otherButtonTitles:nil)

    # Show it to the user
    @alert_box.show
  end


  def textFieldShouldReturn textField
    textField.resignFirstResponder
    true
  end
end
