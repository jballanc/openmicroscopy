/*
 * org.openmicroscopy.shoola.agents.datamng.editors.CreateDatasetEditorManager
 *
 *------------------------------------------------------------------------------
 *
 *  Copyright (C) 2004 Open Microscopy Environment
 *      Massachusetts Institute of Technology,
 *      National Institutes of Health,
 *      University of Dundee
 *
 *
 *
 *    This library is free software; you can redistribute it and/or
 *    modify it under the terms of the GNU Lesser General Public
 *    License as published by the Free Software Foundation; either
 *    version 2.1 of the License, or (at your option) any later version.
 *
 *    This library is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *    Lesser General Public License for more details.
 *
 *    You should have received a copy of the GNU Lesser General Public
 *    License along with this library; if not, write to the Free Software
 *    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *------------------------------------------------------------------------------
 */

package org.openmicroscopy.shoola.agents.datamng.editors;

//Java imports
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JButton;
import javax.swing.JTextArea;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;

//Third-party libraries

//Application-internal dependencies
import org.openmicroscopy.shoola.agents.datamng.DataManagerCtrl;
import org.openmicroscopy.shoola.env.data.model.DatasetData;
import org.openmicroscopy.shoola.env.data.model.ImageSummary;
import org.openmicroscopy.shoola.env.data.model.ProjectSummary;

/** 
 * 
 *
 * @author  Jean-Marie Burel &nbsp;&nbsp;&nbsp;&nbsp;
 * 				<a href="mailto:j.burel@dundee.ac.uk">j.burel@dundee.ac.uk</a>
 * @author  <br>Andrea Falconi &nbsp;&nbsp;&nbsp;&nbsp;
 * 				<a href="mailto:a.falconi@dundee.ac.uk">
 * 					a.falconi@dundee.ac.uk</a>
 * @version 2.2 
 * <small>
 * (<b>Internal version:</b> $Revision$ $Date$)
 * </small>
 * @since OME2.2
 */
public class CreateDatasetEditorManager
	implements ActionListener, DocumentListener, MouseListener
{
	private static final int		SAVE = 0;
	private static final int		SELECT_PROJECT = 1;
	private static final int		CANCEL_SELECTION_PROJECT = 2;
	private static final int		SELECT_IMAGE = 3;
	private static final int		CANCEL_SELECTION_IMAGE = 4;
	
	private CreateDatasetEditor 	view;
	private DatasetData 			model;
	private DataManagerCtrl			control;
	
	private List					projects;
	
	private List					images;
	
	/** List of images to be added. */
	private List					imagesToAdd;
	
	/** List of projects to be added to. */
	private List					projectsToAdd;
	
	/** Select button displayed in the {@link CreateDatasetPane}. */
	private JButton 				saveButton;
	
	/** Select button displayed in the {@link CreateDatasetProjectsPane}. */
	private JButton 				selectButton;
	
	/** Cancel button displayed in the {@link CreateDatasetProjectsPane}. */
	private JButton 				cancelButton;
	
	/** Select button displayed in the {@link CreateDatasetImagesPane}. */
	private JButton					selectImageButton;
	
	/** Cancel button displayed in the {@link CreateDatasetImagesPane}. */
	private JButton					cancelImageButton;
	
	/** textArea displayed in the {@link CreateDatasetPane}. */
	private JTextArea				descriptionArea;
	
	/** text field displayed in the {@link CreateDatasetPane}. */
	private JTextArea				nameField;
		
	private boolean					isName;
	
	public CreateDatasetEditorManager(CreateDatasetEditor view, 
									  DataManagerCtrl control,
									  DatasetData model, List projects,
									  List images)
	{
		this.control = control;
		this.view = view;
		this.model = model;
		this.projects = projects;
		this.images = images;
		isName = false;
	}
	
	DatasetData getDatasetData()
	{
			return model;
	}
	
	List getProjects()
	{
		return projects;
	}
	
	List getImages()
	{
		return images;
	}
		
	/** Initializes the listeners. */
	void initListeners()
	{
		saveButton = view.getSaveButton();
		saveButton.addActionListener(this);
		saveButton.setActionCommand(""+SAVE);
		selectButton = view.getSelectButton();
		selectButton.addActionListener(this);
		selectButton.setActionCommand(""+SELECT_PROJECT);
		cancelButton = view.getCancelButton();
		cancelButton.addActionListener(this);
		cancelButton.setActionCommand(""+CANCEL_SELECTION_PROJECT);
		selectImageButton = view.getSelectImageButton();
		selectImageButton.addActionListener(this);
		selectImageButton.setActionCommand(""+SELECT_IMAGE);
		cancelImageButton = view.getCancelImageButton();
		cancelImageButton.addActionListener(this);
		cancelImageButton.setActionCommand(""+CANCEL_SELECTION_IMAGE);
		nameField = view.getNameField();
		nameField.getDocument().addDocumentListener(this);
		nameField.addMouseListener(this);
		descriptionArea = view.getDescriptionArea();
		descriptionArea.getDocument().addDocumentListener(this);
	}
	
	/** Handles event fired by the buttons. */
	public void actionPerformed(ActionEvent e)
	{
		String s = (String) e.getActionCommand();
		try {
			int     index = Integer.parseInt(s);
			//fo later
			
			switch (index) { 
				case SAVE:
					save();
					break;
				case SELECT_PROJECT:
					selectProject();
					break;
				case CANCEL_SELECTION_PROJECT:
					cancelSelectionProject();
					break;
				case SELECT_IMAGE:
					selectImage();
					break;
				case CANCEL_SELECTION_IMAGE:
					cancelSelectionImage();
					break;
			}// end switch  
		} catch(NumberFormatException nfe) {
		   throw nfe;  //just to be on the safe side...
		} 
	}
	
	/** 
	 * Add (resp. remove) the image summary to (resp. from) the list of
	 * image summary objects to add to the new dataset.
	 * 
	 * @param value		boolean value true if the checkBox is selected
	 * 					false otherwise.
	 * @param ds		dataset summary to add or remove
	 */
	void addImage(boolean value, ImageSummary is) 
	{
		if (imagesToAdd == null) imagesToAdd = new ArrayList();
		if (value == true) imagesToAdd.add(is);
		else 	imagesToAdd.remove(is);
	}
	
	/** 
	 * Add (resp. remove) the project summary to (resp. from) the list of
	 * project summary objects to add to the new dataset.
	 * 
	 * @param value		boolean value true if the checkBox is selected
	 * 					false otherwise.
	 * @param ds		dataset summary to add or remove
	 */
	void addProject(boolean value, ProjectSummary ps) 
	{
		if (projectsToAdd == null) projectsToAdd = new ArrayList();
		if (value == true) projectsToAdd.add(ps);
		else 	projectsToAdd.remove(ps);
	}

	 /** 
	 * Save the new DatasetData object in DB and forward event to the 
	 * {@link DataManagerCtrl}.
	 */
	private void save()
	{
		model.setDescription(descriptionArea.getText());
		model.setName(nameField.getText());
		//update tree and forward event to DB.
		//forward event to DataManager.
		control.addDataset(projectsToAdd, imagesToAdd, model);
		//close widget.
		view.dispose();
	}

	/** Select projects. */
	private void selectProject()
	{
		projectsToAdd = projects;
		view.selectAllProjects();
		selectButton.setEnabled(false);
	}

	/** Cancel selection of projects. */
	private void cancelSelectionProject()
	{
		projectsToAdd = null;
		selectButton.setEnabled(true);
		view.cancelSelectionProject();
	}
	
	/** Select images. */
	private void selectImage()
	{
		imagesToAdd = images;
		view.selectAllImages();
		selectButton.setEnabled(false);
	}

	/** Cancel selection of images. */
	private void cancelSelectionImage()
	{
		imagesToAdd = null;
		selectButton.setEnabled(true);
		view.cancelSelectionImage();
	}
	
	/** Require by I/F. */
	public void changedUpdate(DocumentEvent e)
	{
		if (isName) saveButton.setEnabled(true);
	}

	/** Require by I/F. */
	public void insertUpdate(DocumentEvent e)
	{
		if (isName) saveButton.setEnabled(true);
	}

	/** Require by I/F. */
	public void removeUpdate(DocumentEvent e)
	{
		if (isName) saveButton.setEnabled(true);
	}
	
	/** Indicates that the name has been modified. */
	public void mousePressed(MouseEvent e)
	{ 
		isName = true;
	}

	/** 
	 * Required by I/F but not actually needed in our case, no op 
	 * implementation.
	 */ 
	public void mouseClicked(MouseEvent e) {}

	/** 
	 * Required by I/F but not actually needed in our case, no op 
	 * implementation.
	 */ 
	public void mouseEntered(MouseEvent e) {}

	/** 
	 * Required by I/F but not actually needed in our case, no op 
	 * implementation.
	 */ 
	public void mouseExited(MouseEvent e) {}

	/** 
	 * Required by I/F but not actually needed in our case, no op 
	 * implementation.
	 */ 
	public void mouseReleased(MouseEvent e){}
	
}
